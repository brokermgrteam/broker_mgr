# encoding: utf-8
class Month < ActiveRecord::Base
  attr_accessible :month, :year

  has_many :custindices

  default_scope :order => 'id DESC'
  scope :past_months, where("id between ? and ?", 1.year.ago.strftime("%Y%m"), Date.today.strftime("%Y%m")) 
end
# == Schema Information
#
# Table name: months
#
#  id         :integer(38)     not null, primary key
#  year       :integer(38)
#  month      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

