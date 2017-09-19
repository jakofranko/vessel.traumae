class Aeth
    
    attr_accessor :name, :data
    
    def initialize name, data
        
        @name = name.capitalize
        @data = data
        
        print data.inspect
    end
    
    def capitalizations
        
    end
    
end