require 'openssl'
require 'base64'


class DecryptController < ApplicationController
  def decrypt
    if params["commit"] == "Decrypt"
      key = Base64.decode64(params["secret_key"])
      decipher = OpenSSL::Cipher::AES.new(256, :CBC)
      decipher.decrypt
      decipher.key = key
      decoded = decipher.update(Base64.decode64(params["encrypted_str"])) + decipher.final
      params["decrypted_str"] = decoded
    end
  end

end
