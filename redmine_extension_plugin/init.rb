# coding: utf-8

require 'redmine'
require 'open-uri'

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| load(f) }


Redmine::Plugin.register :redmine_extension_plugin do
  name 'Redmine Extension Plugin'
  author 'Bryt Li'
  author_url 'https://github.com/bryt-li/redmine_extension_plugin.git'
  description 'Extend standard Redmine implementation.'
  version '0.0.1'

  # replact :update action of WikiController
  WikiController.class_eval do
    remove_method :update

    if respond_to?(:helper_method)
      include ApplicationHelper
      helper_method :ex_wiki_page_to_pdf
    end
    include ExWikiHelper
    include ExWikiControllerActions
  end

  DocumentsController.class_eval do
    skip_before_action :authorize, :session_expiration, :user_setup, :check_if_login_required, :set_localization, :check_password_change, only: [:show]
  end

end
