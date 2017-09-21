class ActionTest
   
   include Action
    
   def initialize q = nil
      
      super
       
      @name = "Test"
      @docs = "Test the Traumae actions and objects"
       
   end
   
   def act q = nil
       
       load_folder("#{@host.path}/objects/*")
       
       @aebeth = Aebeth.new(@host.path)
       
       
   end
    
end