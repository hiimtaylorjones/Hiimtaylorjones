Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self
  policy.style_src   :self, :https, :unsafe_inline
  policy.connect_src :self, :https

  if Rails.env.development?
    policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035"
  end
end

Rails.application.config.content_security_policy_nonce_generator =
  ->(_request) { SecureRandom.base64(16) }
