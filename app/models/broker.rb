# encoding: utf-8
class Broker < ActiveRecord::Base
  belongs_to :branch
  belongs_to :user
  
  has_many :brokerindices
  has_many :salaries
  has_many :brokerrels, :dependent => :destroy,
                        :foreign_key => "rel_broker_id"
  has_many :relbrokers, :through => :brokerrels, :source => :broker
  has_many :custbrokerrels
  has_many :custs, :through => :custbrokerrels
  has_many :brokerproductrels
  has_many :products, :through => :brokerproductrels
  
  # default_scope :order => 'brokers.broker_code'
  
  scope :typebrokers, lambda { |brokertype| where("broker_type = ?", brokertype) } 
  
  def to_label
    "#{broker_code} | #{broker_name}"
  end
  
  def favor?(product)
    brokerproductrels.find_by_product_id(product)
  end
  
  def favor!(product)
    brokerproductrels.create!(:product_id => product.id)
  end
  
  def unfavor!(product)
    brokerproductrels.find_by_product_id(product).destroy
  end
  
  def self.search(search)
    if search
      @brokers = Broker.limit(20).find(:all,:conditions => 
                  ['CONCAT(broker_code, \'-\', broker_name) = ? OR broker_code LIKE ? OR broker_name LIKE ?', "#{search}","%#{search}%", "%#{search}%"])
    else
      @brokers = nil
    end
  end
  
  # def branchtypebrokers(broker_type)
  #   self.find_by_broker_type(broker_type)
  # end
end
# == Schema Information
#
# Table name: brokers
#
#  id                   :integer(38)     not null, primary key
#  broker_code          :string(255)
#  broker_name          :string(255)
#  branch_id            :integer(38)
#  age                  :integer(38)
#  open_date            :string(255)
#  close_date           :string(255)
#  certificate_num      :string(255)
#  certificate_addr     :string(255)
#  mobile               :string(255)
#  phone                :string(255)
#  fax                  :string(255)
#  email                :string(255)
#  birthday             :string(255)
#  bank_account         :string(255)
#  graduate_college     :string(255)
#  graduate_date        :string(255)
#  major                :string(255)
#  earliest_date        :string(255)
#  agreement_begin_date :string(255)
#  agreement_end_date   :string(255)
#  compact_no           :string(255)
#  broker_qualify_no    :string(255)
#  cert_first_date      :string(255)
#  cert_valite_date     :string(255)
#  cert_get_date        :string(255)
#  exam_pass_date       :string(255)
#  job_qualify          :string(255)
#  passed_exam          :string(255)
#  broker_qualify       :string(255)
#  personnel_manning    :string(255)
#  remark               :text
#  created_at           :datetime
#  updated_at           :datetime
#  avatar               :string(255)
#  broker_type          :integer(38)
#  user_id              :integer(38)
#  region_manager       :boolean(1)
#  gender               :integer(38)
#  broker_level         :integer(38)
#  broker_status        :integer(38)
#  jobstatus            :integer(38)
#  user_code            :string(255)
#  certificate_type     :integer(38)
#  risk_balance         :decimal(, )
#  broker_degree        :integer(38)
#  zqbz                 :integer(38)
#

