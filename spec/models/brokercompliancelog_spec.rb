require 'spec_helper'

describe Brokercompliancelog do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: brokercompliancelogs
#
#  id              :integer(38)     not null primary key
#  broker_id       :integer(38)
#  compliance_type :integer(38)
#  occur_sum       :integer(38)
#  occur_date      :datetime
#  user_id         :integer(38)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  month_id        :integer(38)
#  remark          :string(255)
#

