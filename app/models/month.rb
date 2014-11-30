# encoding: utf-8
class Month < ActiveRecord::Base
  attr_accessible :month, :year

  has_many :custindices

  default_scope :order => 'id DESC'
  scope :past_months, where("id between ? and ?", 1.year.ago.strftime("%Y%m"), Date.today.strftime("%Y%m")) 
end
