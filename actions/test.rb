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
       @documentation = Documentation.new(@host.path).to_s
       @ehrivevnv = Ehrivevnv.new(@host.path)
       print @ehrivevnv.to_letters "Ki Saxan semke"
      #  @aebeth.list

   end

end