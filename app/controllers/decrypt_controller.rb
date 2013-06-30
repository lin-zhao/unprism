require 'openssl'
require 'base64'


class DecryptController < ApplicationController
  def decrypt
    if params["commit"] == "Decrypt"
      key = OpenSSL::PKey::RSA.new(params["public_key"])
      decoded = Base64.decode64(params["encrypted_str"])
      params["decrypted_str"] = key.public_decrypt(decoded)
    end
  end

end
