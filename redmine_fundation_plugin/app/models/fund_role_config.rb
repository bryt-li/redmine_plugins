class FundRoleConfig < ActiveRecord::Base

	validates_presence_of :name
	validates_presence_of :monthly_salary

end