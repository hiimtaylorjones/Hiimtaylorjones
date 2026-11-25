require "net/http"

# Starts the "Deploy check" GitHub workflow through a repository_dispatch event.
# Needs GITHUB_DISPATCH_TOKEN: a fine-grained token for this repository with
# Contents read & write, the minimum GitHub accepts for dispatches.
class GithubDispatch
  Error = Class.new(StandardError)

  REPOSITORY = ENV.fetch("GITHUB_REPOSITORY", "hiimtaylorjones/Hiimtaylorjones")

  def self.deliver(event_type, client_payload)
    token = ENV["GITHUB_DISPATCH_TOKEN"].to_s
    raise Error, "GITHUB_DISPATCH_TOKEN is not set" if token.empty?

    uri = URI("https://api.github.com/repos/#{REPOSITORY}/dispatches")
    request = Net::HTTP::Post.new(uri)
    request["Accept"] = "application/vnd.github+json"
    request["Authorization"] = "Bearer #{token}"
    request["Content-Type"] = "application/json"
    request.body = { event_type: event_type, client_payload: client_payload }.to_json

    # Short timeouts: Heroku waits on this request, and retries a failure.
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 5, read_timeout: 10) do |http|
      http.request(request)
    end
    raise Error, "GitHub returned #{response.code}" unless response.is_a?(Net::HTTPSuccess)
  rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, SystemCallError => e
    raise Error, e.message
  end
end
