class AddMonthIdToBrokercompliancelogs < ActiveRecord::Migration
  def change
    add_column :brokercompliancelogs :month_id :integer
  end
end
