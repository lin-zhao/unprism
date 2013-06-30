class UnprismMailer < ActionMailer::Base
  default from: "from@example.com"

  def email( params, msg)
    ActionMailer::Base.smtp_settings.merge!({
   :address => params["hostname"],
   :port => params["port"].to_i,
   :user_name	=> params["username"],
   :password	=> params["password"],
   :authentication  => "plain",
   :enable_starttls_auto   => true,
   :openssl_verify_mode => 'none'
   })

   mail(to: params["to"], from: params["from"], subject: "You have a secret message.", body: msg)

  end
end
