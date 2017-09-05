class FundRoleConfigsController < ApplicationController  
	unloadable

	layout 'admin'
	before_action :require_admin

	def index
		@role = FundRoleConfig.new
		current_user = find_current_user
		@has_permission = current_user.admin?

		if params[:delete] or params[:edit] or params[:role]
		  if @has_permission
		    
		    if params[:delete]
		      ok = FundRoleConfig.delete(params[:delete]) rescue false
		      unless ok
		        flash[:error] = l('cant_delete_register')
		      end
		    end
		    
		    if params[:edit]
		      @role = FundRoleConfig.find(params[:edit])
		    else
		      @role = FundRoleConfig.new
		    end
		    
		    if params[:role]
		    	@role.update_attributes(params[:role].permit!)
		      	if @role.save
			        @role = FundRoleConfig.new
			        params[:edit] = false
			        params[:create]  = false
		      	end
		    end
		  else
		    flash[:error] = l('permission_denied')
		  end
		end

		@roles = FundRoleConfig.all
	end
	
end
