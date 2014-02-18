class Channel < ActiveRecord::Base
  attr_accessible :channel_code, :channel_name, :channel_type, :institution_id, :remark, :status

  belongs_to :institution

  validates :channel_code, :presence   => true,
                       		 :uniqueness => true
  validates :channel_name, :presence   => true
  validates :channel_type, :presence   => true
  validates :status, 			 :presence   => true
end
# == Schema Information
#
# Table name: channels
#
#  id             :integer(38)     not null, primary key
#  channel_code   :string(255)
#  channel_name   :string(255)
#  channel_type   :integer(38)
#  institution_id :integer(38)
#  status         :boolean(1)
#  remark         :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

