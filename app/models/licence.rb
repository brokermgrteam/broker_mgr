# encoding: utf-8
class Licence < ActiveRecord::Base
  attr_accessible :secure_hash, :expires_on

  def verify?(string)
    secure_hash == check_hash("#{expires_on}-#{string}")
  end

  private
    def check_hash(string)
      Digest::SHA1.hexdigest(string)
    end
end
