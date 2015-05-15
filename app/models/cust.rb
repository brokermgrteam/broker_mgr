# encoding: utf-8
class Cust < ActiveRecord::Base
  attr_accessible :address, :assessment_date, :branch_id, :capital_account, :capital_account_type, :close_date,
                  :cust_name, :identification_number, :identification_type, :mobile, :open_date, :phone, :status,
                  :valid_date, :valid_date_crop, :zip_code, :birthday, :services

  belongs_to :branch
  has_many   :custbrokerrels
  has_many   :custbrokerproductrels
  has_many   :brokerfavcusts
  has_many   :custindices
  has_many   :months, :through => :custindices

  def is_cust?(cust_sym)
    self.any? { |c| c.capital_account == cust_sym }
  end

  def brokerrel
    self.custbrokerrels.first
  end

  def ha
    self.services.include? "1"
  end

  def sa
    self.services.include? "2"
  end

  def hb
    self.services.include? "3"
  end

  def sb
    self.services.include? "4"
  end

  def hg
    self.services.include? "H"
  end

  def otc
    self.services.include? "O"
  end

  def wx
    self.services.include? "w"
  end

  def rzrq
    self.services.include? "R"
  end
end

# == Schema Information
#
# Table name: custs
#
#  id                    :integer(38)     not null, primary key
#  capital_account       :string(10)
#  cust_name             :string(255)
#  identification_type   :integer(38)
#  identification_number :string(255)
#  address               :string(255)
#  phone                 :string(255)
#  mobile                :string(255)
#  zip_code              :string(255)
#  branch_id             :integer(38)
#  status                :integer(38)
#  capital_account_type  :integer(38)
#  open_date             :string(8)
#  close_date            :string(8)
#  valid_date            :string(8)
#  assessment_date       :string(8)
#  valid_date_crop       :string(8)
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  birthday              :datetime
#  services              :string(255)
#
