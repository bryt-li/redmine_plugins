# coding: utf-8

module WikiMacro
	
	Redmine::WikiFormatting::Macros.register do
      desc <<-eos
Mark article for print begin
Usage:
      article_begin(header|footer)
eos

	    macro :article_begin, :parse_args => false do |obj, args, text|

  			header = args.split('|')[0]
  			footer = args.split('|')[1]

  			headerHtml = "<thead class=\"Header\"><tr><td>#{header}<hr /></td></tr></thead>"
  			footerHtml = "<tfoot><tr><td><hr /><span>#{footer}</span><span class=\"PageNum\"></span></td></tr></tfoot>"
  			body = "<table id=\"Container\"> #{headerHtml} #{footerHtml} <tbody><tr><td>"

  	    result = "#{ CGI::unescapeHTML(body) }".html_safe
	    	return result
	    end
	end

	Redmine::WikiFormatting::Macros.register do
      desc <<-eos
Mark article for print end
Usage:
      article_end(part)
Example:
      article_end(章)
      article_end(部分)
eos
	    macro :article_end, :parse_args => false do |obj, args, text|

        part = args

        js = "var part = \"#{part}\";"
      	js = js + <<-eos
var numbers = [
  '一','二','三','四','五','六','七','八','九','十',
  '十一','十二','十三','十四','十五','十六','十七','十八','十九','二十',
  '二十一','二十二','二十三','二十四','二十五','二十六','二十七','二十八','二十九','三十',
  '三十一','三十二','三十三','三十四','三十五','三十六','三十七','三十八','三十九','四十',
  '四十一','四十二','四十三','四十四','四十五','四十六','四十七','四十八','四十九','五十'];

$('.part').each(function(index,element){
  element.innerText = '第' + numbers[index] + part + ' ' + element.innerText;
});

$('.term th').each(function(index,element){
  element.innerText = '第' + numbers[index] + '条' + element.innerText;
});

$('#Container img').each(function(index,element){
  element.parentNode.setAttribute('style','text-align:center;width:100%;');
});

var node = $('#Container h1:first').get(0);
var h1=0;
var h2=0;
var h3=0;
while(node){
    if(node.tagName == 'H1'){
        h1++;h2=0;h3=0;
        node.innerText = h1+'. '+node.innerText;
    }
    if(node.tagName == 'H2'){
        h2++;h3=0;
        node.innerText = h1+'.'+h2+'. '+node.innerText;
    }
    if(node.tagName == 'H3'){
        h3++;
        node.innerText = h1+'.'+h2+'.'+h3+'. '+node.innerText;
    }
    node = node.nextSibling;
}
eos

			html = "</td></tr></tbody></table>"

			content = html + "<script>#{js}</script>"
		    result = "#{ CGI::unescapeHTML(content) }".html_safe
	    	return result

	    end
	end

	Redmine::WikiFormatting::Macros.register do
      desc <<-eos
Mark article part
Usage:
      part(text)
Example:
      part(Introduction)
      part(Conclusion)
eos
	    macro :part, :parse_args => false do |obj, args, text|
	    	content = "<div class=\"part\">#{args}</div>"
		    result = "#{ CGI::unescapeHTML(content) }".html_safe
	    	return result
		end
	end

  Redmine::WikiFormatting::Macros.register do
      desc <<-eos
Mark article term
Usage:
      term(text)
Example:
      term(blah...blah...)
eos
      macro :term, :parse_args => false do |obj, args, text|
        content = "<table class=\"term\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><th></th><td>#{args}</td></tr></table>"
        result = "#{ CGI::unescapeHTML(content) }".html_safe
        return result
    end
  end

end