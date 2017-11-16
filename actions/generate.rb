class ActionGenerate

    include Action

    def initialize q = nil

        super

        @name = "Generate"
        @docs = "Generate the Traumae Dictionaery memory"

    end

    def act params

        load_folder("#{@host.path}/objects/*")

        @dict = Dictionaery.new(@host.path).english_to_traumae
        @english_length = max_word_length

        memory = to_memory

        # Put the memory to stdout for creating the file
        puts memory

        # And return it in case something else must be done
        return memory

    end

    def to_memory

        dictionary = "~ NAME : Traumae Dictionary"
        dictionary += add("~ NOTE : The Traumae Dictionaery")
        dictionary += add("~ AUTH : Devine Lu Linvega")
        dictionary += add("~ EDIT : Jake Franklin")
        dictionary += add("")
        dictionary += add("@ ENGLISH#{pad("@ ENGLISH")}TRAUMAE")
        @dict.each do |english, traumae|

           dictionary += add("#{english}#{pad(english)}#{traumae}")

        end

        return dictionary

    end

    private

    def add string

        return "\n#{string}"

    end

    def pad word

        return " " * (@english_length - word.length + 4)

    end

    def max_word_length

        max = 0
        @dict.each {|english, _| max = english.length > max ? english.length : max }
        return max > "@ ENGLISH".length ? max : "@ ENGLISH".length

    end

end