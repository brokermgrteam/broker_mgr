# encoding: utf-8
class Custservvisit < ActiveRecord::Base
  attr_accessor   :user_name
  attr_accessible :assit_user_id, :attchment_file, :location, :memo, :plan_date, :status,
                  :user_id, :visit_content, :visit_date, :workflowunderway_id, :capital_account, :cust_name, 
                  :plan_location, :visit_location
                  
  belongs_to :workflowunderway
  belongs_to :workflowhistory
  
  attr_writer :capital_account
  
  validate :check_capital_account
  
  before_save :save_capital_account
  
  validates :user_id,    :presence => true
  validates :plan_date,  :presence => true
  
  def capital_account
    @capital_account || Cust.find(cust_id).capital_account if cust_id.present?
  end
  
  def save_capital_account
    self.cust_id = Cust.find_by_capital_account(@capital_account).id if @capital_account.present?
  end
  
  def check_capital_account
    if @capital_account.present? && Cust.find_by_capital_account(@capital_account).nil?
      errors.add :capital_account, "该客户不存在，或不属于团队客户"
    end
  rescue ArgumentError
    errors.add :capital_account, "资金账号有误"
  end
  
end
# == Schema Information
#
# Table name: custservvisits
#
#  id                  :integer(38)     not null, primary key
#  cust_id             :integer(38)
#  cust_name           :string(255)
#  plan_location       :string(255)
#  plan_date           :datetime
#  visit_date          :datetime
#  visit_location      :string(255)
#  attchment_file      :string(255)
#  user_id             :integer(38)
#  assit_user_id       :integer(38)
#  status              :integer(38)
#  visit_content       :string(255)
#  memo                :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  workflowunderway_id :integer(38)
#

