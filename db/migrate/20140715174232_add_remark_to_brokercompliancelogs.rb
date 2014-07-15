class AddRemarkToBrokercompliancelogs < ActiveRecord::Migration
  def change
    add_column :brokercompliancelogs, :remark, :string
  end
end
