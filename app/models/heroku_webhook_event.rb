# One Heroku app webhook delivery (api:build or api:release), reduced to the
# question "should the deploy check run?". Returns the GitHub repository_dispatch
# event to send, or nil when the event is not worth acting on.
#
# Builds are the main trigger: a build finishes before Heroku restarts the
# dynos, so the old, healthy code is still the one receiving this webhook even
# when the new code is about to crash. Releases cover what has no build behind
# it: rollbacks, config var changes, add-on changes.
class HerokuWebhookEvent
  FINISHED = %w[succeeded failed].freeze

  Dispatch = Data.define(:event_type, :client_payload)

  def initialize(payload)
    @payload = payload
    @data = payload.fetch("data", {})
  end

  def dispatch
    case @payload["resource"]
    when "build" then build_dispatch
    when "release" then release_dispatch
    end
  end

  private
    def status
      @data["status"]
    end

    def build_dispatch
      return unless @payload["action"] == "update" && FINISHED.include?(status)

      Dispatch.new("heroku-build", {
        build_id: @data["id"],
        sha: @data.dig("source_blob", "version"),
        status: status
      }.compact)
    end

    # A release reaches a finished status once: either it is created finished
    # (no release phase), or an update moves its status there.
    def release_dispatch
      return unless FINISHED.include?(status)
      return unless @payload["action"] == "create" || @payload.fetch("previous_data", {}).key?("status")
      # Code deploys are already followed from their build event.
      return if @data["description"].to_s.start_with?("Deploy ")

      Dispatch.new("heroku-release", {
        version: @data["version"],
        status: status,
        description: @data["description"]
      }.compact)
    end
end
