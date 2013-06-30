require 'openssl'
require 'base64'
require 'net/smtp'
class SendMailController < ApplicationController
  def index
    puts params.inspect
    if params["commit"] == "Generate keys"
       rsa = OpenSSL::PKey::RSA.generate(2048)
       params["private_key"] = rsa.to_s
       params["public_key"] = rsa.public_key.to_s
    elsif params["commit"] == "Send Email"
       do_send
    end    
  end

  def do_send      
      key = OpenSSL::PKey::RSA.new(params["private_key"])    
      plain_text = "Subject:" + params["subject"] + "\n" + params["body"];
      encrypted = key.private_encrypt(plain_text)
      encoded = Base64.encode64(encrypted)
      
      message = encoded

#      smtp = Net::SMTP.new( params["hostname"], params["port"].to_i)
#      smtp.enable_tls
#      smtp.starttls
#      smtp.send_message message, params["from"], [params["to"]]
#     smtp.quit

      UnprismMailer.email(params, message).deliver

  end   
end
