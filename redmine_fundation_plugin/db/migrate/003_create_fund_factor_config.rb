class CreateFundFactorConfig < ActiveRecord::Migration[5.1]

	class FundFactorConfig < ActiveRecord::Base
	end

	def change
		# fund factor configs
		create_table :fund_factor_configs do |t|
			t.float :money_factor, :default => 1, :null => false
			t.float :resource_factor, :default => 1, :null => false
			t.float :work_factor, :default => 1, :null => false
		end
		say "Created fund_factor_configs table."

		reversible do |dir|
			# Only insert when doing migration up
			# Otherwise uninstall will fail due to duplicated insert
			dir.up do
				fund_factor_configs = 	{
					:money_factor => 4,
					:resource_factor => 3,
					:work_factor => 2
				}
				FundFactorConfig.create fund_factor_configs
				say "Insert fund factor configs."
			end
		end
	end

end

