class ActionGenerate

    include Action

    def initialize q = nil

        super

        @name = "Generate"
        @docs = "Generate the Traumae Dictionaery memory and letters hash"

    end

    def act params

        load_folder("#{@host.path}/objects/*")

        @ehrivevnv = Ehrivevnv.new(@host.path)
        @dict = Dictionaery.new(@host.path).english_to_traumae
        @english_length = max_word_length

        if(params == "memory")
            memory = to_memory

            # Put the memory to stdout for creating the file
            puts memory

            # And return it in case something else must be done
            return memory
        elsif(params == "letters")
            letters = to_letters

            # for stdout
            puts letters.to_json

            # And return...
            return letters
        end

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

    def to_letters

        letters = {}
        alts = ['letter', 'alt', 'septambres']
        dict = @ehrivevnv.list
        dict.each do |aeth, english|
            alts.each do |alt|
                if !letters[alt] then letters[alt] = {} end
                c = @ehrivevnv.to_letters(aeth.downcase, alt == 'letter' ? nil : alt, false)
                if !letters[alt][c] then letters[alt][c] = {} end
                letters[alt][c][:traumae] = aeth
                letters[alt][c][:english] = english
            end
        end

        return letters
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