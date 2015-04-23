class ChangeColumnsOnBrokers < ActiveRecord::Migration
  def up
    remove_column :brokers, :broker_type
    add_column :brokers, :broker_type, :integer
    
    add_column :brokers, :user_id, :integer
    
    remove_column :brokers, :region_manager
    add_column :brokers, :region_manager, :boolean
    
    remove_column :brokers, :gender
    add_column :brokers, :gender, :integer
    
    remove_column :brokers, :broker_level
    add_column :brokers, :broker_level, :integer
    
    remove_column :brokers, :broker_status
    add_column :brokers, :broker_status, :integer
    
    remove_column :brokers, :jobstatus
    add_column :brokers, :jobstatus, :integer
    
    remove_column :brokers, :employee_code
    add_column :brokers, :user_code, :string
    
    remove_column :brokers, :certificate_type
    add_column :brokers, :certificate_type, :integer
    
    remove_column :brokers, :risk_balance
    add_column :brokers, :risk_balance, :float
    
    remove_column :brokers, :broker_degree
    add_column :brokers, :broker_degree, :integer
    
    remove_column :brokers, :zqbz
    add_column :brokers, :zqbz, :integer
    
    remove_column :brokers, :post
    remove_column :brokers, :team_name
    
  end

  def down
  end
end
