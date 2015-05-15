class Subchannel < ActiveRecord::Base
  attr_accessible :channel_id, :status, :sub_channel_broker, :sub_channel_code, :sub_channel_name

  belongs_to :channel

  def to_label
    "#{sub_channel_code} | #{sub_channel_name}"
  end
end
# == Schema Information
#
# Table name: subchannels
#
#  id                 :integer(38)     not null, primary key
#  channel_id         :integer(38)
#  sub_channel_code   :string(255)
#  sub_channel_name   :string(255)
#  sub_channel_broker :string(255)
#  status             :boolean(1)      default(TRUE)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#
# == Schema Information
#
# Table name: subchannels
#
#  id                 :integer(38)     not null, primary key
#  channel_id         :integer(38)
#  sub_channel_code   :string(255)
#  sub_channel_name   :string(255)
#  sub_channel_broker :string(255)
#  status             :boolean(1)      default(TRUE)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

