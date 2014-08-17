class Custindex < ActiveRecord::Base
  attr_accessible :bj_balance, :cust_id, :fd_balance, :lh_balance, :month_id, :rzrq_end_asset, :rzrq_g_commis,
                  :rzrq_g_match_balance, :rzrq_j_commis, :rzrq_j_match_balance, :stock_asset, :stock_commis,
                  :stock_match_balance, :total_asset, :total_commis, :total_match_balance
       
       belongs_to :cust
end
# == Schema Information
#
# Table name: custindices
#
#  id                   :integer(38)     not null, primary key
#  cust_id              :integer(38)
#  month_id             :integer(38)
#  total_asset          :decimal(, )
#  stock_asset          :decimal(, )
#  rzrq_end_asset       :decimal(, )
#  bj_balance           :decimal(, )
#  fd_balance           :decimal(, )
#  lh_balance           :decimal(, )
#  total_match_balance  :decimal(, )
#  stock_match_balance  :decimal(, )
#  rzrq_g_match_balance :decimal(, )
#  rzrq_j_match_balance :decimal(, )
#  total_commis         :decimal(, )
#  stock_commis         :decimal(, )
#  rzrq_g_commis        :decimal(, )
#  rzrq_j_commis        :decimal(, )
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  pure_total_income    :decimal(, )
#  pure_interest_psr    :decimal(, )
#  pure_interest_gh     :decimal(, )
#  pure_interest_krb    :decimal(, )
#

