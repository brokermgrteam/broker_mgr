class Institution < ActiveRecord::Base
  attr_accessible :institution_code, :institution_name

  has_many :channels
end
# == Schema Information
#
# Table name: institutions
#
#  id               :integer(38)     not null, primary key
#  institution_code :string(255)
#  institution_name :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

