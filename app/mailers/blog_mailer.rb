class BlogMailer < ApplicationMailer
  def creation_confirmation(blog)
    @blog = blog
    @user = blog.user
    mail(to: @user.email, subject: "ブログの作成が完了しました")
  end
end
