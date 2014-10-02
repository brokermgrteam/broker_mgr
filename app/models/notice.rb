# encoding: utf-8
class Notice < ActiveRecord::Base
  attr_accessible :content, :title, :user_id

  belongs_to :user

  has_many :readnotices

  default_scope  order('created_at DESC')

  scope :recent, unscoped.order('created_at DESC').limit(10)
end
# == Schema Information
#
# Table name: notices
#
#  id         :integer(38)     not null, primary key
#  title      :string(255)
#  content    :string(255)
#  user_id    :integer(38)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

