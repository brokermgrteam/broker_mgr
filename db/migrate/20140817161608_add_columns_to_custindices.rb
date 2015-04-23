class AddColumnsToCustindices < ActiveRecord::Migration
  def change
    add_column :custindices, :pure_total_income, :float
    add_column :custindices, :pure_interest_psr, :float
    add_column :custindices, :pure_interest_gh,  :float
    add_column :custindices, :pure_interest_krb, :float
  end
end
