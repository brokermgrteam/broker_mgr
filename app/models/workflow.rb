# encoding: utf-8
class Workflow < ActiveRecord::Base
  attr_accessible :code :name :steps :workflowsteps_attributes
  
  # has_many :flowpositionrels :dependent => :destroy 
  #                              :foreign_key => "flowid"
  has_many :workflowsteps :dependent => :destroy
  has_many :userpositions :through => :workflowsteps
  has_many :workflowunderways
  has_many :workflowhistories
  
  accepts_nested_attributes_for :workflowsteps
                              
  validates :name  :presence   => true
                    :length     => { :maximum => 20 }
                    :uniqueness => true
  validates :steps :presence   => true
  
end
# == Schema Information
#
# Table name: workflows
#
#  id         :integer(38)     not null primary key
#  code       :string(255)
#  name       :string(255)
#  steps      :integer(38)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

