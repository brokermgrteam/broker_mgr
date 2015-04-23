# encoding: utf-8
class Notice < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :file

  belongs_to :user

  has_many :readnotices
  has_many :users, :through => :readnotices

  mount_uploader :file, AttachmentUploader

  validates :title,  :presence => true, 
                     :length => { :maximum => 100 }

  scope :recent, unscoped.order('notices.created_at DESC').limit(10)
  scope :unread, lambda { |user| {:conditions => ['notices.id not in (?)', user.notices.map(&:id)]} unless user.notices.empty?}

  def belongs_to_user?(user)
  	self.readnotices.exists?(:user_id => user)
  end

end
# == Schema Information
#
# Table name: notices
#
#  id         :integer(38)     not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer(38)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  file       :string(255)
#

