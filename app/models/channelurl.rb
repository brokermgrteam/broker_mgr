class Channelurl < ActiveRecord::Base
  attr_accessible :url, :channel_id, :branch_id, :serv_branch_id, :broker_id, :wapurl,
                  :sub_channel_id, :bank_id

  belongs_to :channel

  validates :channel_id,  :presence   => true
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
#  wapurl         :string(255)
#  sub_channel_id :integer(38)
#  bank_id        :integer(38)
#

