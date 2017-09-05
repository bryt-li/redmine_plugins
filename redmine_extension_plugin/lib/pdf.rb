# encoding: utf-8
#
# Redmine - project management software
# Copyright (C) 2006-2017  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'rbpdf'

module Redmine
  module Export
    module PDF
      class EXITCPDF < RBPDF
        include Redmine::I18n
        attr_accessor :footer_date

        def initialize(lang, header, orientation='P')
          @header_content = header
          @@k_path_cache = Rails.root.join('tmp', 'pdf')
          FileUtils.mkdir_p @@k_path_cache unless File::exist?(@@k_path_cache)
          set_language_if_valid lang
          super(orientation, 'mm', 'A4')
          set_print_header(true)
          set_rtl(l(:direction) == 'rtl')
          set_margins(17,20,15,true)

          @font_for_content = l(:general_pdf_fontname)
          @monospaced_font_for_content = l(:general_pdf_monospaced_fontname)
          @font_for_footer  = l(:general_pdf_fontname)
          set_creator(Redmine::Info.app_name)
          set_font(@font_for_content)

          set_header_font([@font_for_content, '', 10])
          set_footer_font([@font_for_content, '', 8])
          set_default_monospaced_font(@monospaced_font_for_content)
          set_display_mode('default', 'OneColumn')
        end

        def SetFontStyle(style, size)
          set_font(@font_for_content, style, size)
        end

        def SetFont(family, style='', size=0, fontfile='')
          # FreeSerif Bold Thai font has problem.
          style.delete!('B') if family.to_s.casecmp('freeserif') == 0
          # DejaVuSans Italic Arabic and Persian font has problem.
          style.delete!('I') if family.to_s.casecmp('dejavusans') == 0 && current_language.to_s.casecmp("vi") != 0
          # DejaVuSansMono Italic Arabic font has problem
          style.delete!('I') if family.to_s.casecmp('dejavusansmono') == 0
          super(family, style, size, fontfile)
        end
        alias_method :set_font, :SetFont

        def fix_text_encoding(txt)
          RDMPdfEncoding::rdm_from_utf8(txt, "UTF-8")
        end

        def formatted_text(text)
          Redmine::WikiFormatting.to_html(Setting.text_formatting, text)
        end

        def RDMCell(w ,h=0, txt='', border=0, ln=0, align='', fill=0, link='')
          cell(w, h, txt, border, ln, align, fill, link)
        end

        def RDMMultiCell(w, h=0, txt='', border=0, align='', fill=0, ln=1)
          multi_cell(w, h, txt, border, align, fill, ln)
        end

        def RDMwriteFormattedCell(w, h, x, y, txt='', attachments=[], border=0, ln=1, fill=0)
          @attachments = attachments

          css_tag = ' <style>
          p{
            line-height:7px;
          }
          img{
            margin:5px auto;
          }
          table, td {
            border: 2px #ff0000 solid;
          }
          th {  background-color:#EEEEEE; padding: 4px; white-space:nowrap; text-align: center;  font-style: bold;}
          pre {
            background-color: #fafafa;
          }
          </style>'

          # Strip {{toc}} tags
          txt.gsub!(/<p>\{\{([<>]?)toc\}\}<\/p>/i, '')
          writeHTMLCell(w, h, x, y, css_tag + txt, border, ln, fill)
        end

        def RDMwriteHTMLCell(w, h, x, y, txt='', attachments=[], border=0, ln=1, fill=0)
          txt = formatted_text(txt)
          RDMwriteFormattedCell(w, h, x, y, txt, attachments, border, ln, fill)
        end

        def get_image_filename(attrname)
          atta = RDMPdfEncoding.attach(@attachments, attrname, "UTF-8")
          if atta
            return atta.diskfile
          else
            #return nil
            attrname_utf8 = Redmine::CodesetUtil.to_utf8(attrname,"UTF-8")
            # check of unsafe URI
            if attrname_utf8 =~ /[^-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]%]/n
              return URI.encode(attrname_utf8)
            else
              return attrname_utf8
            end
          end
        end

        def get_sever_url(url)
          if !empty_string(url) and (url[0, 1] == '/')
            Setting.host_name.split('/')[0] + url
          else
            url
          end
        end

        def Header
          set_font(@font_for_footer, 'I', 12)
          RDMCell(180, 5, @header_content, 0, 0, 'C')
          line(20,16,195,16)
        end

        def Footer
          set_font(@font_for_footer, 'I', 12)
          set_x(-30)
          RDMCell(0, 5, get_alias_num_page() + '/' + get_alias_nb_pages(), 0, 0, 'C')
        end
      end

      class RDMPdfEncoding
        def self.rdm_from_utf8(txt, encoding)
          txt ||= ''
          txt = Redmine::CodesetUtil.from_utf8(txt, encoding)
          txt.force_encoding('ASCII-8BIT')
          txt
        end

        def self.attach(attachments, filename, encoding)
          filename_utf8 = Redmine::CodesetUtil.to_utf8(filename, encoding)
          atta = nil
          if filename_utf8 =~ /^[^\/"]+\.(gif|jpg|jpe|jpeg|png)$/i
            atta = Attachment.latest_attach(attachments, filename_utf8)
          end
          if atta && atta.readable? && atta.visible?
            return atta
          else
            return nil
          end
        end
      end
    end
  end
end