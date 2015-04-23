class Channel < ActiveRecord::Base
  attr_accessible :channel_code, :channel_name, :channel_type, :institution_id, :remark, :status

  belongs_to :institution
  has_many   :channelurls

  validates :channel_code, :presence   => true,
                       		 :uniqueness => true,
                           :numericality => {:only_integer => true},
                           :length     => { :maximum => 4 }
  validates :channel_name, :presence   => true
  validates :channel_type, :presence   => true
  # validates :status, 			 :presence   => true

  scope :valid_channels, where(:status => true ) 

  def to_label
    "#{channel_code} | #{channel_name}"
  end
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

