# As Rails 5 disabled the autoloading so i have to load manualy
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| load(f) }

Redmine::Plugin.register :redmine_inventory_plugin do
  name 'Redmine Inventory Plugin'
  author 'Bryt Li'
  description 'Redmine Inventory Plugin'
  version '0.9'
  url 'https://github.com/bryt-li/redmine-inventory-plugin'

  permission :inventory, {:inventory => [:index, :movements, :categories, :parts, :warehouses, :providors]}, :public => false

  menu :top_menu, :inventory, { :controller => 'inventory', :action => 'index' }, { :caption => :inventory_home, :before => 'admin'}
  menu :top_menu, :sale, { :controller => 'sale', :action => 'index' }, { :caption => :sale_home, :before => 'admin'}
    
  settings :default => {'empty' => true}, :partial => 'settings/rim_settings'
end
