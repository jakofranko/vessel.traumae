class Ehriv_aeth

    attr_accessor :root_meaning, :data

    def initialize name, data

        @root = name
        @meanings = data

        i = @meanings.find_index { |v| v.include? "letter :" }
        @letter = @meanings.delete_at(i).split(" : ")[1]

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

    def to_table

        html =  "<table class='traumae ehrivevnv'>"

        traumae = self.capitalizations
        index = 0
        traumae.each do |aeth|
            html += "<tr>"
            if index == 0
                html += "<td rowspan='3' class='ehriv_aeth'>#{@letter}</td>"
            end
            html += "<td>#{self.to_english(index)} (#{traumae[index]})</td>"
            html += "</tr>"
            index += 1
        end

        html += "</table>"
        return html

    end
end