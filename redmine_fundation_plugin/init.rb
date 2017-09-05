require "redmine"

# As Rails 5 disabled the autoloading in prod so i have to load manualy
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| load(f) }


RedmineApp::Application.routes.prepend do
  # we can replace route here...
  
    #  get '/time_entries/new', :to => 'timelog#fund_new'
    #  post '/time_entries/', :to => 'timelog#fund_create'
end

Redmine::Plugin.register :redmine_fundation_plugin do
  name 'Redmine Fundation Plugin'
  author 'Li Xin'
  description 'This is the Fundation plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/bryt-li/fundation.git'
  author_url 'http://bryt.li/about'

  project_module :funds do
    permission :view_funds, :funds => :index
  end

  menu :project_menu, :funds, { :controller => 'funds', :action => 'index' }, :caption => :fundation

  menu :admin_menu, :fund_settings, { :controller => 'fund_role_configs', :action => 'index' }, :caption => :fundation, :html => {:class => 'icon icon-stats'}

  TimeEntry.safe_attributes 'fund_total', 'fund_is_frozen', 'fund_frozen_time', 'fund_money', 'fund_money_factor', 'fund_resource', 'fund_resource_factor', 'fund_work', 'fund_work_role', 'fund_work_role_monthly_salary', 'fund_work_factor'

  # replace :new and :create action 
#  TimelogController.class_eval do
#    remove_method :new
#    remove_method :create
#  end
#  TimelogController.class_eval { include ExTimelogControllerActions }
end

Rails.configuration.to_prepare do
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks

  unless TimelogController.included_modules.include? TimelogControllerPatch
    TimelogController.send(:include, TimelogControllerPatch)
  end
end

