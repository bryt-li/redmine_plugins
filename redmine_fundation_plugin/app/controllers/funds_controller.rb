class FundsController < ApplicationController  

	before_action :check_partner
	before_action :check_owner, :only => [:edit, :update, :update_frozen]

	#Display pie and list all fund time logs.
	def index
		@factor = FundFactorConfig.find(1)
		entries = TimeEntry.find_by_sql("SELECT * FROM time_entries WHERE fund_total>0 AND fund_is_frozen=1 ORDER BY created_on")
		@total = 0
		@total_money = 0
		@shareholders = {}
		entries.each do |entry|
			name = entry.user.firstname
			if @shareholders.has_key?(entry.user.id)
				@shareholders[entry.user.id][:fund] += entry.fund_total || 0
				@shareholders[entry.user.id][:money] += entry.fund_money || 0
				@shareholders[entry.user.id][:resource] += entry.fund_resource || 0
				@shareholders[entry.user.id][:work] += entry.fund_work || 0
				@shareholders[entry.user.id][:money_fund] += (entry.fund_money || 0)*entry.fund_money_factor
				@shareholders[entry.user.id][:resource_fund] += (entry.fund_resource || 0)*entry.fund_resource_factor
				@shareholders[entry.user.id][:work_fund] += (entry.fund_work || 0)*entry.fund_work_factor
			else
				@shareholders[entry.user.id] = {
					:name => name,
					:fund => entry.fund_total || 0,
					:money => entry.fund_money || 0,
					:resource => entry.fund_resource || 0,
					:work => entry.fund_work || 0,
					:money_fund => (entry.fund_money || 0)*entry.fund_money_factor,
					:resource_fund => (entry.fund_resource || 0)*entry.fund_resource_factor,
					:work_fund => (entry.fund_work || 0)*entry.fund_work_factor
				}
			end
			@total += entry.fund_total if entry.fund_total
			@total_money += entry.fund_money if entry.fund_money
		end
	end

	def unfrozen
		@entries = TimeEntry.find_by_sql("SELECT * FROM time_entries WHERE fund_total>0 AND (fund_is_frozen IS NULL OR fund_is_frozen=0) ORDER BY created_on")
	end

	def frozen
		@entries = TimeEntry.find_by_sql("SELECT * FROM time_entries WHERE fund_total>0 AND fund_is_frozen=1 ORDER BY created_on")
	end

	def edit
    end

    def update
	    if @time_entry.update(params[:time_entry])
	        respond_to do |format|
		        format.html {
		          flash[:notice] = l(:notice_successful_update)
		          redirect_back_or_default fund_path()
		        }
		        format.api  { render_api_ok }
      		end
	    else
	    	respond_to do |format|
		        format.html { render :action => 'edit' }
		        format.api  { render_validation_errors(@time_entry) }
	    	end
		end
    end

    def update_frozen
	    if @time_entry.update({:fund_is_frozen => params[:frozen]})
	        respond_to do |format|
		        format.html {
		          flash[:notice] = l(:notice_successful_update)
		          redirect_back_or_default params[:url]
		        }
		        format.api  { render_api_ok }
      		end
	    else
	    	respond_to do |format|
		        format.html { render :action => 'edit' }
		        format.api  { render_validation_errors(@time_entry) }
	    	end
		end
    end

	private
		def check_partner
			is_partner = false
		    User.current.groups.each do |g|
		      puts g.lastname
		      if g.lastname == 'Partner'
		        is_partner = true
		      end
		    end

		    if !is_partner
		      render_403
		      return
		    end
		end

		def check_owner
			@time_entry = TimeEntry.find(params[:id])
			current_user = find_current_user
		    if User.current.id != @time_entry.user_id && !current_user.admin?
		    	render_403
	      		return
	      	end
		end
end


