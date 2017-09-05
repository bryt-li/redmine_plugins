# coding: utf-8

module WikiMacro
  
  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Enable graphviz image map navigation
Usage:
      enable_graph_nav(repo)
      enable_graph_nav(project|repo)

      in Graphviz Image use following to generate node link:
        URL="imagename.jpg|[width]|[height],[wiki]"
        URL="wiki|[width]|[height]"
eos
    macro :enable_graph_nav, :parse_args => true do |obj, args, text|
      prj = obj.page.wiki.project.identifier
      repo = args[0]
      if repo.index('|')
        prj = repo.split('|').at(0)
        repo = repo.split('|').at(-1)
      end

      html = <<-eos
      <div id="dialog" title="预览">
        <a style="display:none;" id="dialog_img" target="_blank" href="#"><img src=""/></a>
        <iframe style="display:none;" id="dialog_iframe" src=""></iframe>
      </div>
      eos

      js = "var project='#{prj}'; var repository='#{repo}';"
      js = js + <<-eos
      $( "area" ).each(function( index ) {
        var href = $(this).attr("href").split(',');
        var res = href[0].split('|')[0];

        var img = null;
        var wiki = null;
        var page = null;

        if(res.indexOf('.')>0)
        {
          img = '/projects/'+project+'/repository/'+repository+'/revisions/master/raw/'+res;
          if(href[1])
              wiki = '/projects/'+project+'/wiki/'+href[1];
        }else{
          page = '/projects/'+project+'/wiki/'+res;
        }

        var width = href[0].split('|')[1];
        if(!width) width='800';
        var height = href[0].split('|')[2];
        if(!height) height=600;

        $(this).click(function(e){
          if(img){
            $('#dialog_img').show();
            $('#dialog_iframe').hide();
            $('#dialog_img img').attr('src',img).css('width',width-30).css('height',height-60);
            if(wiki)
               $('#dialog_img').attr('href',wiki);
            else
               $('#dialog_img').attr('href','#');
          }else{
            $('#dialog_iframe').show();
            $('#dialog_img').hide();
            $('#dialog_iframe').attr('src',page).css('width',width-30).css('height',height-30);
          }

          $('#dialog').dialog({
            height: height,
            width: width,
            modal: true});
          e.preventDefault();
        });
      });
      eos

      content = html + "<script>#{js}</script>"
      
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end