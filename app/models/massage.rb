class Massage < ActiveRecord::Base
  attr_accessible :content, :file, :messenger_id, :title, :user_id, :status, :brokerteammodify_attributes

  belongs_to :user
  has_one :brokerteammodify

  accepts_nested_attributes_for :brokerteammodify

  mount_uploader :file, AttachmentUploader

  validates :title,  :presence => true,
                     :length => { :maximum => 100 }

  scope :recent, unscoped.order('massages.created_at DESC').limit(10)
  scope :unread, lambda { |user| {:conditions => ['status = ? AND user_id = ?', false, user.id]} }
  scope :read, lambda { |user| {:conditions => ['status = ? AND user_id = ?', true, user.id]} }

  def read?
  	self.status
  end
end
# == Schema Information
#
# Table name: massages
#
#  id           :integer(38)     not null, primary key
#  title        :string(255)
#  content      :text
#  user_id      :integer(38)
#  messenger_id :integer(38)
#  file         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  status       :integer(38)
#
# == Schema Information
#
# Table name: massages
#
#  id           :integer(38)     not null, primary key
#  title        :string(255)
#  content      :text
#  user_id      :integer(38)
#  messenger_id :integer(38)
#  file         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  status       :boolean(1)
#

