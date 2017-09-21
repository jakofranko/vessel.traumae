class Aeth
    
    attr_accessor :root_meaning, :data
    
    def initialize name, data
        
        @root_meaning = name.capitalize
        @aeth_data = data
        
        print data.inspect
    end
    
    def capitalization cap

       vowel = @aeth_data["vowel"]

       case cap
       when 0
           @aeth_data["root"] >> vowel
        when 1
            @aeth_data["median"]["root"] >> vowel
        when 2
            @aeth_data["opposite"]["root"] >> vowel
        end

    end

    def capitalizations
        
    end
    
end