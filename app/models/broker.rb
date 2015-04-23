# encoding: utf-8
class Broker < ActiveRecord::Base
  belongs_to :branch
  belongs_to :user

  has_many :brokerindices
  has_many :salaries
  has_many :brokerrels :dependent => :destroy
                        :foreign_key => "rel_broker_id"
  has_many :relbrokers :through => :brokerrels :source => :broker
  has_many :custbrokerrels
  has_many :custs :through => :custbrokerrels
  has_many :custbrokerproductrels
  has_many :productcusts :through => :custbrokerproductrels :source => :cust
  has_many :brokerfavcusts
  has_many :favcusts :through => :brokerfavcusts :source => :cust
  has_many :brokerproductrels
  has_many :products :through => :brokerproductrels

  # default_scope :order => 'brokers.broker_code'

  scope :valid_brokers where("broker_status <> #{Dict.find_by_dict_type_and_code('BrokerBase.status' 2).id}")
  scope :typebrokers lambda { |brokertype| where("broker_type = ?" brokertype) }

  def to_label
    "#{broker_code} | #{broker_name}"
  end

  def valid?
    Broker.find_by_id_and_broker_status(self.idDict.find_by_dict_type_and_code('BrokerBase.status' 2).id).nil? if self.present?
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

  def favor_cust?(cust)
    brokerfavcusts.find_by_cust_id(cust)
  end

  def favor_cust!(cust)
    brokerfavcusts.create!(:cust_id => cust.id)
  end

  def unfavor_cust!(cust)
    brokerfavcusts.find_by_cust_id(cust).destroy
  end

  def self.search(search)
    if search
      @brokers = Broker.limit(20).find(:all:conditions =>
                  ['CONCAT(broker_code \'-\' broker_name) = ? OR broker_code LIKE ? OR broker_name LIKE ?' "#{search}""%#{search}%" "%#{search}%"])
    else
      @brokers = nil
    end
  end

  # def branchtypebrokers(broker_type)
  #   self.find_by_broker_type(broker_type)
  # end
end
