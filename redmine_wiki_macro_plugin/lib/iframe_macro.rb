module WikiMacro

  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Insert iframe tag.
  iframe(url,width='100%',height='400pt',scrolling='yes')
Usage:
  iframe(http://www.google.com/,80%,400px,projectid)
eos

    macro :iframe, :parse_args => true do |obj, args|

      url = args[0]

      width = '100%'
      width = args[1].strip if args[1]
      height = '400pt'
      height = args[2].strip if args[2]

      scrolling = 'yes'
      scrolling = args[3].strip if args[3]

      style = 'border:0;width:'+width+';height:'+height;
      if scrolling == 'no'
        style = style + ';overflow:hidden;'
      end

      o = ''
      o << '<iframe src="' + url + '" style="'+ style + '" width="' + width +
        '" height="' + height + '" frameborder="0" scrolling="' + scrolling + '"></iframe>'

      result = "#{ CGI::unescapeHTML(o) }".html_safe
      return result
    end
  end

  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Insert iframe tag for wiki page.
  iframe_wiki(wiki,width='100%',height='400pt',project='current',scroll='yes')

  when optional args not specified:
    width defaults to 100%
    height defaults to 400pt
    project defaults to current
    scrolling defaults to yes

Usage:
  iframe_wiki(wikiid,80%,400px,projectid)
eos

    macro :iframe_wiki, :parse_args => true do |obj, args|

      wiki = args[0]

      width = '100%'
      width = args[1].strip if args[1]
      height = '400pt'
      height = args[2].strip if args[2]
      project_id = obj.page.wiki.project.identifier
      project_id = args[3].strip if args[3]

      scrolling = 'yes'
      scrolling = args[4].strip if args[4]

      style = 'border:0;width:'+width+';height:'+height;
      if scrolling == 'no'
        style = style + ';overflow:hidden;'
      end

      url = "/projects/#{project_id}/wiki/#{wiki}"
      o = ''
      o << '<iframe src="' + url + '" style="'+ style + '" width="' + width +
        '" height="' + height + '" frameborder="0" scrolling="' + scrolling + '"></iframe>'

      result = "#{ CGI::unescapeHTML(o) }".html_safe
      return result
    end
  end

end
