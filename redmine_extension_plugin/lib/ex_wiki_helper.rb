module ExWikiHelper

	# Returns a PDF string of a single wiki page
	def ex_wiki_page_to_pdf(page, project)
		pdf = Redmine::Export::PDF::EXITCPDF.new(current_language,"#{page.title}")
		pdf.set_title("#{project} - #{page.title}")
		pdf.alias_nb_pages
		pdf.footer_date = format_date(User.current.today)
		pdf.add_page
		# Set resize image scale
		pdf.set_image_scale(1.6)
		pdf.SetFontStyle('',12)
		write_wiki_page(pdf, page)
		pdf.output
	end

    def write_wiki_page(pdf, page)
    	p page.content
    	parts = page.content.text.split('******')
    	i=0
    	parts.each do |part|
    		page.content.text = part
			text = textilizable(page.content, :text,
				:only_path => false,
				:edit_section_links => false,
				:headings => false,
				:inline_attachments => false
			)
			if(i>0)
				pdf.add_page
			end
			pdf.RDMwriteFormattedCell(180,5,'','', text, page.attachments, 0)
			i = i+1
		end
	end

end
