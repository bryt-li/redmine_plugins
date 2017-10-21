class CreateFundRoleConfig < ActiveRecord::Migration

	class FundRoleConfig < ActiveRecord::Base
	end

	def change
		
		# fund role configs
		create_table :fund_role_configs do |t|
			t.string :name, :limit => 30, :default => "", :null => false
			t.integer :monthly_salary, :default => 0, :null => false
		end
		add_index :fund_role_configs, [:name], :unique => true
		say "Created fund_role_configs table."


		reversible do |dir|
			# Only insert when doing migration up
			# Otherwise uninstall will fail due to duplicated insert
			dir.up do
				# Add init role configurations here!!!
				roles = [
					{:name => "Executive Director", :monthly_salary => 10000},
					{:name => "CEO", :monthly_salary => 10000},
				]
				# insert roles
				roles.each do |role|
					FundRoleConfig.create role
					say "Inserted role: #{role}"
				end
			end
		end

	end

end

