ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 587,
    domain: 'luke.rogers1843@gmail.com',
    user_name: Rails.application.credentials.smtp_username,
    password: Rails.application.credentials.smtp_password,
    authentication: :login,
    enable_starttls_auto: true
  }