class ContactForm < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message

  def headers
    admin = User.where(admin: true, receives_notifs: true).first.email
    {
      subject: 'BitAztec | Mensaje via Contacto',
      to: admin,
      from: %("#{name}" <#{email}>)
    }
  end
end
