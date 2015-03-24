class Channelurl < ActiveRecord::Base
  attr_accessible :url, :channel_id, :branch_id, :serv_branch_id, :broker_id, :wapurl

  belongs_to :channel
end
# == Schema Information
#
# Table name: channelurls
#
#  id             :integer(38)     not null, primary key
#  url            :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  channel_id     :integer(38)
#  branch_id      :integer(38)
#  serv_branch_id :integer(38)
#  broker_id      :integer(38)
#

