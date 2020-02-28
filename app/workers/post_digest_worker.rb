class PostDigestWorker
  include Sidekiq::Worker

  def perform(email)
    created_before = Time.now - 30.days
    posts = Post.where('created_at >= ?', 1.month.ago)
    PostDigestMailer.monthly_post_digest(email, posts).deliver_now
  end

end