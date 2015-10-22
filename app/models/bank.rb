# encoding: utf-8
class Bank < ActiveRecord::Base
  attr_accessible :bank_code, :bank_name, :status

  default_scope   :order => 'banks.bank_code'

  def to_label
    "#{bank_code} | #{bank_name}"
  end
end
# == Schema Information
#
# Table name: banks
#
#  id         :integer(38)     not null, primary key
#  bank_code  :string(255)
#  bank_name  :string(255)
#  status     :boolean(1)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

