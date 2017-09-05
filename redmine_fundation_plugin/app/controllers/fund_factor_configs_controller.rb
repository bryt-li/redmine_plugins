class FundFactorConfigsController < ApplicationController  
	unloadable

	layout 'admin'
	before_action :require_admin

	def index
		current_user = find_current_user
		@has_permission = current_user.admin?

		@factor = FundFactorConfig.find(1)

		if(@has_permission)
			if params[:factor]
				@factor.update_attributes(params[:factor].permit!)
		      	if @factor.save
			        params[:edit] = false
		      	end
		    end
		else
		    flash[:error] = l('permission_denied')
		end
	end
	
end
