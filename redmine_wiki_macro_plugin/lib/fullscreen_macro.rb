module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Enter fullscreen mode for wiki page.
Usage:
      fullscreen
eos
    macro :fullscreen, :parse_args => true do |obj, args|

      content = <<-eos
<style type="text/css">
#header,#sidebar,#footer,#top-menu,#wiki_add_attachment,.contextual,.other-formats,.breadcrumb,.wiki-update-info,.other-formats,#content fieldset{display:none;}
#content{width:100%;}
#main{padding:0;margin:0;}
</style>
      eos

      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end
