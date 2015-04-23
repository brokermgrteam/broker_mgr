# encoding: utf-8
class Systemupgradelog < ActiveRecord::Base
  # attr_accessible :description, :update_date

  default_scope   :order => 'systemupgradelogs.update_date DESC'
  
end
# == Schema Information
#
# Table name: systemupgradelogs
#
#  id          :integer(38)     not null, primary key
#  update_date :datetime
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

