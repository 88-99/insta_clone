class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: "email", subject: "投稿完了メール"
  end
end
