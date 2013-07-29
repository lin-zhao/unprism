require 'openssl'
require 'base64'
require 'net/smtp'
class SendMailController < ApplicationController
  def index
    if params["commit"] == "Generate secret"
       cipher = OpenSSL::Cipher::AES.new(256, :CBC)
       cipher.encrypt
       key = cipher.random_key
       params["secret_key"] = Base64.encode64(key)
    elsif params["commit"] == "Send Email"
       do_send
    elsif params["mail_select"] == "lzhao"
       params["hostname"] = "smtp.lzhao.com"
       params["port"] = "587"
    elsif params["mail_select"] == "gmail"
       params["hostname"] = "smtp.gmail.com"
       params["port"] = "587"
    elsif params["mail_select"] == "yahoo"
      params["hostname"] = "smtp.mail.yahoo.com"
      params["port"] ="465"
    elsif params["mail_select"] == "outlook"
      params["hostname"] = "smtp.live.com"
      params["port"] ="587"
    elsif params["mail_select"] == "others"
       params["hostname"] = ""
       params["port"] = ""
    end    
  end

  def do_send      
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key=Base64.decode64(params["secret_key"])
    plain_text = "Subject:" + params["subject"] + "\n" + params["body"];
    encrypted = cipher.update(plain_text) + cipher.final
    encoded = Base64.encode64(encrypted)
    
    message = encoded
    message += "\nTo decrypt this message get the public key from the sender and go to http://lzhao.com/unprism/decrypt"

      UnprismMailer.email(params, message).deliver

  end   
end
