require 'openssl'
class SendMailController < ApplicationController
  def index
    puts params.inspect
    if params["commit"] == "Generate keys"
       rsa = OpenSSL::PKey::RSA.generate(2048)
       params["private_key"] = rsa.to_s
       params["public_key"] = rsa.public_key.to_s
    end    
  end

  def do_send
    
  end   
end
