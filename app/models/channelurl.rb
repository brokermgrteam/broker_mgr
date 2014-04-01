class Channelurl < ActiveRecord::Base
  attr_accessible :url
end
# == Schema Information
#
# Table name: channelurls
#
#  id         :integer(38)     not null, primary key
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

