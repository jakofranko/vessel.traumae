class Ehriv_aeth

    attr_accessor :root, :meanings, :letter, :alt, :july_letters

    def initialize name, data

        @root = name
        @meanings = data

        i = @meanings.find_index { |v| v.include? "letter :" }
        @letter = @meanings.delete_at(i).split(" : ")[1]

        i = @meanings.find_index { |v| v.include? "alt :" }
        @alt = @meanings.delete_at(i).split(" : ")[1]

        i = @meanings.find_index { |v| v.include? "july_letters" }
        @july_letters = @meanings.delete_at(i).split(" : ")[1].split(", ")

    end

    def to_english cap

        case cap
        when 0
            return @meanings[0]
        when 1
            return @meanings[1]
        when 2
            return @meanings[2]
        end

    end

    def capitalization cap

        case cap
        when 0
            aeth = @root
        when 1
            aeth = @root + "N"
        when 2
            aeth = @root + "M"
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

    def to_table alt = nil

        glyph = case alt
                when "alt"  then @alt
                when "july" then @july_letters
                else             @letter
                end

        html =  "<table class='traumae ehrivevnv letters'>"

        traumae = self.capitalizations
        index = 0

        if alt == "july"
            traumae.each do |aeth|
                html += "<tr>"\
                        "<td class='ehriv_aeth #{alt}'>#{glyph[index]}</td>"\
                        "<td>#{self.to_english(index)} (#{traumae[index]})</td>"\
                        "</tr>"
                index += 1
            end
        else
            traumae.each do |aeth|
                html += "<tr>"
                if index == 0
                    html += "<td rowspan='3' class='ehriv_aeth'>#{glyph}</td>"
                end
                html += "<td>#{self.to_english(index)} (#{traumae[index]})</td>"
                html += "</tr>"
                index += 1
            end
        end

        html += "</table>"
        return html

    end
end