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
      puts @aebeth.list
      # @documentation = Documentation.new(@host.path).to_s
      # @ehrivevnv = Ehrivevnv.new(@host.path)
      # puts @ehrivevnv.to_letters "Ki Saxan semke"
      # puts @aebeth.to_letters("pi vabi so ti", "recit")
      @dictionaery = Dictionaery.new(@host.path)
      # puts @dictionaery.traumae_to_english
      # puts @dictionaery.english_to_traumae
      # puts @dictionaery.to_traumae("race skeleton peak experience bob's your uncle")
      # puts @dictionaery.to_english("Tiso lado xoka to")
      puts @dictionaery.literal("Tiso")

   end

end