class Aebeth 
    
    def initialize path
       
       load_any(path, "aeth")
       
       @h = Memory_Hash.new("aebeth", path).to_h("aeth")
    #   print @h.inspect
       
    end
        
end