class Aeth

    attr_accessor :root_meaning, :data

    def initialize name, data

        @root_meaning = name.capitalize
        @aeth_data = data

    end

    def to_english cap

        case cap
        when 0
            return @root_meaning
        when 1
            return @aeth_data["median"]["meaning"]
        when 2
            return @aeth_data["opposite"]["meaning"]
        end

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

end