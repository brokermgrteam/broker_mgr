require 'spec_helper'

describe Subchannel do
  pending "add some examples to (or delete) #{__FILE__}"
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

