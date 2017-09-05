require 'redmine'

module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Includes a page of WIKI by specifing project and wiki
    include(wiki)
    include(project:wiki)
Usage:
    include(Foo)
    include(Project:Wiki)
eos
    macro :include do |obj, args|
      page = Wiki.find_page(args.first.to_s, :project => @project)
      if page.nil?
        project = ''
        title = ''
        if !obj.nil?
          project = obj.page.wiki.project.identifier 
          title = obj.page.title
        end
        content = "<div class=\"include_wiki_not_exist\"><a style=\"color:red;\" href=\"/projects/#{project}/wiki/#{args.first.to_s}?parent=#{title}\">#{args.first.to_s}</a></div>"
        return "#{ CGI::unescapeHTML(content) }".html_safe
      else
        # don't check authority when include.
        #raise 'Page not exist' if !User.current.allowed_to?(:view_wiki_pages, page.wiki.project)
        out = textilizable(page.content, :text, :attachments => page.attachments, :headings => false)
        out
      end
    end
  end

end

