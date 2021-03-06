require_relative "../../vessel.oscean/objects/index.rb"
class Documentation

    def initialize path

        @h = Memory_Hash.new("documentation", path).to_h
        @index = Index.new
        @css = ['font.ehrivevnv.css', 'font.septambres.css']

    end

    def to_s

        html = ""
        @h.each do |heading, paragraphs|
            if heading == "SOURCES" then next end
            parent = nil
            html += @index.add(:root, heading.downcase.to_sym)
            paragraphs.each do |p|
                @index.add(heading.downcase.to_sym, p[1..-1].strip) if p[0, 1] == "="
            end

            html += paragraphs.runes

        end

        return styles + @index.to_s(true) + html + scripts

    end

    def styles

        return "
        <style>
            @media (max-width: 740px) {
                .traumae.letters {
                    float: none;
                }
            }

            .traumae.aeth {
                width: 100%;
            }

            .traumae.aeth caption {
                text-align: left;
                margin-bottom: 10px;
            }

            .traumae.aeth th:nth-child(1) {
                width: 10%;
            }

            .traumae.aeth th:nth-child(2) {
                width: 25%;
            }

            .traumae.letters {
                width: 33.3%;
                float: left;
            }

            .ehriv_aeth {
                font-family: 'ehrivevnv';
                font-size: 72px;
                line-height: 1em;
            }

            .ehriv_aeth.july {
                font-family: 'ehrivevnv_july';
            }

            table .july.ehriv_aeth {
                font-size: 46px;
            }

            .traumae.letters tr:first-child td:first-child {
                text-align: center;
                vertical-align: middle;
                width: 15%;
            }

            .septambres-recit {
                font-family: 'septambres_recit';
                font-size: 48px;
            }
            table .septambres-recit {
                font-size: 20px;
            }

            .neau {
                font-family: 'septambres_neau';
                font-size: 48px;
            }
            table .neau {
                font-size: 20px;
            }

            .fune {
                font-family: 'septambres_fune';
                font-size: 96px;
                letter-spacing: 0.06em;
            }
            table .fune {
                font-size: 48px;
            }

            .lith {
                font-family: 'septambres_lith';
                font-size: 14px;
                line-height: 5em;
            }
            table .lith {
                font-size: 5px;
            }

            #translator:after {
                clear: both;
                content: '';
                display: table;
            }

            #tra_to_eng, #eng_to_tra, #letters_to_both {
                box-sizing: border-box;
                width: 30%;
                float: left;
            }

            #tra_to_eng, #eng_to_tra {
                padding-right: 1em;
                margin-right: 1em;
                border-right: 2px solid black;
            }

            #tra_to_eng textarea, #eng_to_tra textarea, #letters_to_both textarea {
                box-sizing: border-box;
                width: 100%;
                height: 100px;
                padding: 16px;
            }

            #tra_output, #eng_output {
                box-sizing: border-box;
                padding: 16px;
            }

            textarea.july {
                font-size: 48px;
            }
            textarea.lith {
                font-size: 10px;
            }
            textarea.fune {
                font-size: 72px;
            }

        </style>
        "

    end

    def scripts

        html = "<script>"
        index = 0
        @css.each do |file_name|
            html += "var link_#{index} = document.createElement('link');"
            html += "link_#{index}.rel = 'stylesheet';"
            html += "link_#{index}.href = 'public.traumae/links/#{file_name}';"
            html += "document.head.appendChild(link_#{index});"

            index += 1
        end
        html += "</script>"
        html += "<script src='public.traumae/scripts/translator.js'></script>"

    end

end