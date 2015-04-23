# encoding: utf-8
class Userposition < ActiveRecord::Base
  attr_accessible :name
  
  # has_many :userpositionrels :dependent => :destroy 
  #                               :foreign_key => "positionid"
  has_many :workflowsteps
  has_many :users            :through => :userpositionrels 
                              :source => :user     
                              
  validates :name  :presence => true :length => { :maximum => 20 } :uniqueness => true
end
# == Schema Information
#
# Table name: userpositions
#
#  id         :integer(38)     not null primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

