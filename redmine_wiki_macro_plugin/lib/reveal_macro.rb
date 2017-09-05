module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Start a PPT wiki page.

Syntax:
  {{begin_ppt(theme)
    <h2 style="line-height:1.2em;">这是PPT标题<br />PPT汇报</h2>
    <hr style="margin:0.8em 0 0.8em 0;"/>
    <h4 style="text-align:left;">Subject</h4>
    <h3 style="line-height:1.3em;">This is sub-subject<br />break line.</h3>
    <h4 style="text-align:right;line-height:1.5em;">汇报人：Author<br />YYYY年MM月</h4>
  }}

Available themes: 
  beige
  black
  blood
  league
  moon
  night
  serif
  simple
  sky
  solarized
  white

Available Transitions:
  none
  slide
  fade
  convex
  concave
  zoom
eos

    macro :begin_ppt, :parse_args => true do |obj, args, text|
      theme = "black"
      theme = args[0] if args[0]
      transition = "slide"
      transition = args[1] if args[1]

      content = '<script> var head = document.getElementsByTagName("head")[0], '
      content = content + 't = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/reveal.js/css/reveal.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t); '
      content = content + 't = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/' + theme + '.css"; t.id="theme"; t.media="all"; t.rel="stylesheet"; head.appendChild(t); '
      content = content + 't = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/reveal.js/lib/css/zenburn.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t); '
      content = content + 'var transition = "'+transition+'";'
      content = content + '</script>'
      content = content + <<-eos
      <div class="reveal">
        <div class="slides">
            <section>
              <section id="cover">
eos

      content = content + text

      content = content + <<-eos
              </section>
              <section id="themes">
                <h2>Change Themes</h2>
                <hr style="margin:2em;" />
                <p>
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/black.css'); return false;">Black (default)</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/white.css'); return false;">White</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/league.css'); return false;">League</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/sky.css'); return false;">Sky</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/beige.css'); return false;">Beige</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/simple.css'); return false;">Simple</a> <br>
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/serif.css'); return false;">Serif</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/blood.css'); return false;">Blood</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/night.css'); return false;">Night</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/moon.css'); return false;">Moon</a> -
                  <a href="#" onclick="document.getElementById('theme').setAttribute('href','/plugin_assets/bryt_wiki_extension/reveal.js/css/theme/solarized.css'); return false;">Solarized</a>
                </p>
              </section>
              <section id="transitions"> 
                <h2>Change Transition Styles</h2>
                <hr style="margin:2em;" />
                <p>
                  <a href=" ">None</a > - 
                  <a href="?transition=fade#/transitions">Fade</a > - 
                  <a href="?transition=slide#/transitions">Slide</a > - 
                  <a href="?transition=convex#/transitions">Convex</a > - 
                  <a href="?transition=concave#/transitions">Concave</a > - 
                  <a href="?transition=zoom#/transitions">Zoom</a > 
                </p >
             </section>
            </section>
eos

      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end



  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
End a PPT wiki page.

Syntax:
  {{end_ppt}}
eos

    macro :end_ppt, :parse_args => true do |obj, args, text|

      content = <<-eos
      </div>
    </div>
    <script src="/plugin_assets/bryt_wiki_extension/reveal.js/lib/js/head.min.js"></script>
    <script src="/plugin_assets/bryt_wiki_extension/reveal.js/js/reveal.js"></script>

    <script>
      $('#wrapper').replaceWith($('div.reveal'));

      Reveal.initialize({
        history: true,
        transition: transition,
        dependencies: [
          { src: '/plugin_assets/bryt_wiki_extension/reveal.js/plugin/markdown/marked.js' },
          { src: '/plugin_assets/bryt_wiki_extension/reveal.js/plugin/markdown/markdown.js' },
          { src: '/plugin_assets/bryt_wiki_extension/reveal.js/plugin/notes/notes.js', async: true },
          { src: '/plugin_assets/bryt_wiki_extension/reveal.js/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } }
        ]
      });
    </script>
eos

      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end


  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Make PPT section
Usage:
      {{ppt(attr)
        
        content...

      }}
eos

    macro :ppt, :parse_args => true do |obj, args, text|
      section_attr = ''
      section_attr = ' ' + args[0].gsub(/，/,',').gsub(/；/,';').gsub(/（/,'(').gsub(/）/,')') if args[0]
      content = "<section#{section_attr}>#{text}</section>"
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end
  
  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Make PPT markdown section
Usage:
      {{ppt_md(attr)
        
        content...

      }}
eos

    macro :ppt_md, :parse_args => true do |obj, args, text|
      section_attr = ' data-markdown'
      section_attr = ' data-markdown ' + args[0].gsub(/，/,',').gsub(/；/,';').gsub(/（/,'(').gsub(/）/,')') if args[0]
      content = "<section#{section_attr}><script type=\"text/template\">#{text}</script></section>"
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Begin a vertical parent PPT section 
Usage:
      {{ppt_vertical_begin(attr)}}
eos

    macro :ppt_vertical_begin, :parse_args => true do |obj, args, text|
      section_attr = ''
      section_attr = ' ' + args[0].gsub(/，/,',').gsub(/；/,';').gsub(/（/,'(').gsub(/）/,')') if args[0]
      content = "<section#{section_attr}>"
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
End a vertical parent PPT section
Usage:
      {{ppt_vertical_end}}
eos

    macro :ppt_vertical_end, :parse_args => true do |obj, args, text|
      content = "</section>"
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end


end
