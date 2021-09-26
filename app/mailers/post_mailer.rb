class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: "xz835.525o39@yahoo.com", subject: "投稿完了メール"
  end
end
