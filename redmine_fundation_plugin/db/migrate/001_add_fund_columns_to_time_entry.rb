class AddFundColumnsToTimeEntry < ActiveRecord::Migration[5.1]

	def change
		# add column to time_entries table
		add_column :time_entries, :fund_total, :integer, :null => true
		add_column :time_entries, :fund_is_frozen, :boolean, :null => false, :default => false
		add_column :time_entries, :fund_frozen_time, :date, :null => true

		add_column :time_entries, :fund_money, :integer, :null => true
		add_column :time_entries, :fund_money_factor, :float, :null => true
		
		add_column :time_entries, :fund_resource, :integer, :null => true
		add_column :time_entries, :fund_resource_factor, :float, :null => true
		
		add_column :time_entries, :fund_work, :integer, :null => true
		add_column :time_entries, :fund_work_role, :string, :null => true
		add_column :time_entries, :fund_work_role_monthly_salary, :integer, :null => true
		add_column :time_entries, :fund_work_factor, :float, :null => true

		say "Add columns to time_entries table."

	end

end

