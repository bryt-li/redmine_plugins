class FundFactorConfig < ActiveRecord::Base

	validates_presence_of :money_factor
	validates_presence_of :resource_factor
	validates_presence_of :work_factor

end