class Dictionaery

    attr_accessor :traumae_to_english
    attr_accessor :english_to_traumae

    def initialize path

        @path = path
        @aebeth = Aebeth.new(path)
        @aebeth_list = @aebeth.list
        @traumae_to_english = Memory_Hash.new("dictionaery", path).to_h
        @english_to_traumae = reverse_dict

    end

    def to_english sentence

        possible_meanings = {}
        words = sentence.split(" ")

        # Gather the possible meanings of each word
        words.each do |word|
            word.downcase!
            if @traumae_to_english[word] && !possible_meanings[word]
                possible_meanings[word] = @traumae_to_english[word].dup
            end
        end

        # Then, assemble possible sentences
        most_possible_meanings = get_longest(possible_meanings)

        # Create an array of arrays, with each sub-array being a possible sentence
        english = Array.new(most_possible_meanings) { Array.new }
        words.each do |word|
            if possible_meanings[word]
               most_possible_meanings.times do |i|
                    if possible_meanings[word][i]
                        english[i] << possible_meanings[word][i]
                    else
                        english[i] << possible_meanings[word][0]
                    end
               end
            else
                most_possible_meanings.times do |i|
                    english[i] << word
                end
            end
        end

        # Finally return a string of the possible sentences
        temp = []
        english.each do |arr|
            temp << arr.join(" ")
        end

        return temp.join("\n")

    end

    def to_traumae sentence

        traumae = []
        words = sentence.split(" ")
        words.each do |word|
            word.downcase!
            if @english_to_traumae[word]
                traumae << @english_to_traumae[word]
            else
                traumae << "<unknown>"
            end
        end

        return traumae.join(" ")

    end

    def literal word

        meaning = []
        word.downcase.scan(/([ktpxdbslv][iao])/) do |aeth|
            a = aeth[0]
            meaning << @aebeth_list[a] unless !@aebeth_list[a]
        end

        return meaning.join(" ")

    end

    def to_s

        html = "<table>"\
               "<thead><tr><th>Traumae</th><th>English</th><th>Literal</th></tr></thead>"\
               "<tbody>"
        @traumae_to_english.each do |word, english|
            html += "<tr>"
            html += "<td rowspan='#{english.length}'>#{word}</td>"
            english.each_index do |i|
                html += "<tr>" unless i < 1
                html += "<td>#{english[i]}</td>"
                html += "<td rowspan='#{english.length}'>#{self.literal(word)}</td>" unless i > 0
                html += "</tr>"
            end
        end

        html += "</tbody></table>"
        return html

    end


    private
        def reverse_dict

           dict = {}
           @traumae_to_english.each do |traumae, english|
               english.each do |word|
                   dict[word] = traumae
               end
           end

           return dict

        end

        def get_longest hash

            longest = 0
            hash.each_value do |val|
               longest = val.length unless val.length <= longest
            end

            return longest

        end

end