class PostDigestMailer < ApplicationMailer

  default from: 'news@hiimtaylorjones.com'

  def monthly_post_digest(email, posts)
    @posts = posts
    mail(to: email, subject: 'Monthly Post Digest')
  end
end
