# Receives Heroku app webhooks (api:build, api:release) and hands deploys to
# the "Deploy check" GitHub workflow. Subscribed at the `sync` level, so any
# non-2xx response makes Heroku retry the delivery.
class HerokuWebhooksController < ActionController::API
  def create
    secret = ENV["HEROKU_WEBHOOK_SECRET"].to_s
    return head :service_unavailable if secret.empty?
    return head :unauthorized unless valid_signature?(secret)

    dispatch = HerokuWebhookEvent.new(JSON.parse(request.raw_post)).dispatch
    GithubDispatch.deliver(dispatch.event_type, dispatch.client_payload) if dispatch
    head :no_content
  rescue JSON::ParserError
    head :bad_request
  rescue GithubDispatch::Error => e
    Rails.logger.error("Heroku webhook not forwarded to GitHub: #{e.message}")
    head :bad_gateway
  end

  private
    # Heroku signs the raw body: base64 HMAC-SHA256 keyed with the webhook secret.
    def valid_signature?(secret)
      expected = Base64.strict_encode64(OpenSSL::HMAC.digest("SHA256", secret, request.raw_post))
      ActiveSupport::SecurityUtils.secure_compare(expected, request.headers["Heroku-Webhook-Hmac-SHA256"].to_s)
    end
end
