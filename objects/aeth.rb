class Aeth

    attr_accessor :root_meaning, :data

    def initialize name, data

        @root_meaning = name.capitalize
        @aeth_data = data

    end

    def list

        list = {}
        index = 0
        capitalization.each do |cap|
            list[cap] = to_english(index)
            index += 1
        end

        return list

    end

    def to_english cap

        case cap
        when 0
            return @root_meaning + "(#{@aeth_data["alt"]})"
        when 1
            return @aeth_data["median"]["meaning"] + "(#{@aeth_data["median"]["alt"]})"
        when 2
            return @aeth_data["opposite"]["meaning"] + "(#{@aeth_data["opposite"]["alt"]})"
        end

    end

    def to_letter cap

       letter = nil
       case cap
       when 0
           letter = @aeth_data["letter"]
       when 1
           letter = @aeth_data["median"]["letter"]
       when 2
           letter = @aeth_data["opposite"]["letter"]
       end

       return letter

    end


    def capitalization cap

        vowel = @aeth_data["vowel"]

        case cap
        when 0
           aeth = @aeth_data["root"] + vowel
        when 1
            aeth = @aeth_data["median"]["root"] + vowel
        when 2
            aeth = @aeth_data["opposite"]["root"] + vowel
        end

        return aeth
    end

    def capitalizations

        caps = []
        3.times do |i|
            caps.push(self.capitalization(i))
        end

        return caps

    end

    def to_table septambres = nil

        html = ""

        if septambres.nil?
            html +=  "<table class='traumae aeth'>"\
                    "<caption>#{@aeth_data["description"]}</caption>"\
                    "<thead>"\
                    "<tr>"\
                    "<th>Aeth</th>"\
                    "<th>Meaning</th>"\
                    "<th>Notes</th>"\
                    "</tr>"\
                    "</thead>"

            letters = self.capitalizations
            index = 0
            letters.each do |aeth|
                if index == 0
                    root = @aeth_data.dup
                    root["meaning"] = @root_meaning
                elsif index == 1
                    root = @aeth_data["median"]
                elsif index == 2
                    root = @aeth_data["opposite"]
                end

                alt = !root["alt"].nil? ? ", " + root["alt"] : ""
                notes = !root["notes"].nil? ? root["notes"] : ""

                html += "<tr>"\
                        "<td><strong>#{aeth}</strong></td>"\
                        "<td>#{root["meaning"] + alt}</td>"\
                        "<td>#{notes}</td>"\
                        "</tr>"

                index += 1
            end

            html += "</table>"

        else
            c = "septambres-#{septambres}"
            case septambres
            when "recit"
                html += "<table class='traumae letters'>"

                index = 0
                capitalizations.each do |cap|
                    html += "<tr>
                             <td class='#{c}'>#{to_letter(index)}</td>
                             <td>#{cap}</td>
                             </tr>"
                    index += 1
                end

                html += "</table>"
            end
        end

        return html

    end
end