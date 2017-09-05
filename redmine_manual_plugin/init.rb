require "redmine"

=begin
RedmineApp::Application.routes.prepend do
  get 'time_entries', :to => 'extimelog#index'
  get 'projects/:id/time_entries', to: 'extimelog#index'
  get 'issues/:id/time_entries', to: 'extimelog#index'
end
=end

# As Rails 5 disabled the autoloading so i have to load manualy
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| load(f) }


Redmine::Plugin.register :redmine_manual_plugin do
  name 'Redmine Manual Document Plugin'
  author 'Li Xin'
  description 'This is the help document plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/bryt-li/redmine_manual_plugin.git'
  author_url 'http://bryt.li/about'

  #Add ourself help document menu
  menu :top_menu, :manual, { :controller => 'manual', :action => 'index' }, :last => true, :caption => :label_manual
end
