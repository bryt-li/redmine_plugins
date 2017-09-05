# coding: utf-8
#
# vendor/plugins/redmine_wiki_html_util/init.rb
#
require 'redmine'
require 'open-uri'

# As Rails 5 disabled the autoloading so i have to load manualy
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| load(f) }



Redmine::Plugin.register :redmine_wiki_macro_plugin do
  name 'Redmine Wiki Macro Extension Plugin'
  author 'Arlo Carreon, Bryt Li'
  author_url 'https://github.com/bryt-li/redmine_wiki_macro_plugin.git'
  description 'Allows you to embedd RAW HTML into your wiki, load stylesheets and javascript.  Made for html/css/js demo wikis'
  version '0.0.1'
end
