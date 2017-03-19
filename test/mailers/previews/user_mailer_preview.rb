class UserMailerPreview < ActionMailer::Preview

  def welcome
    user = OpenStruct.new(email: 'demo@example.com', name: 'Ernesto')
    UserMailer.welcome(user)
  end

end
