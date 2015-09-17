class Massage < ActiveRecord::Base
  attr_accessible :content, :file, :messenger_id, :title, :user_id
end
