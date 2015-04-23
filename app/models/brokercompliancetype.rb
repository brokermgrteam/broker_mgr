class Brokercompliancetype < ActiveRecord::Base
  attr_accessible :compliance_code :compliance_type :compliance_type_detail
end
# == Schema Information
#
# Table name: brokercompliancetypes
#
#  id                     :integer(38)     not null primary key
#  compliance_code        :integer(38)
#  compliance_type        :string(255)
#  compliance_type_detail :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

