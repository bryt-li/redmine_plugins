module WikiMacro

  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Import an image in repo and give a title for it.
Usage:
      repo_img(repo,img)
      repo_img(repo,img,desc) 
      repo_img(project|repo, img|width|height, desc)
eos
    macro :repo_img, :parse_args => true do |obj, args|

      project_id = obj.page.wiki.project.identifier
      repo = args[0]

      if args[0].index('|')
        project_id = args[0].split('|').at(0)
        repo = args[0].split('|').at(-1)
      end
      
      img = args[1]
      width = ""
      height = ""
      if args[1] and args[1].index('|')
        img = args[1].split('|').at(0)
        width = "width:#{args[1].split('|').at(1)};"
        height = "height:#{args[1].split('|').at(-1)};"
      end

      desc = img.split('/').at(-1).split('.').at(0)
      desc = args[2] if args[2]

      content = "<div class=\"repo_img\"><img style=\"#{width}#{height};\" src=\"/projects/#{project_id}/repository/#{repo}/revisions/master/raw/#{img}\" /><p>#{desc}</p></div>"

      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end
