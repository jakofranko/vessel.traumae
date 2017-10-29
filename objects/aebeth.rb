class Aebeth

    def initialize path

        load_any(path, "aeth")
        @h = Memory_Hash.new("aebeth", path).to_h("aeth")

    end


    def list

        dict = {}

        # Loop through each aeth
        @h.each do |_, aeth|
            # Put each aeth's capitalizations and their definitions in the dict
            cap = 0
            aeth.capitalizations.each do |a|
                dict[a] = aeth.to_english(cap)
                cap += 1
            end
        end

        return dict
    end

    def letters

        letters = {}
        @h.each do |_, aeth|
            cap = 0
            aeth.capitalizations.each do |capitalization|
                letters[capitalization] = aeth.to_letter(cap)
                cap += 1
            end
        end

        return letters

    end

    def to_table type = nil

        html = ""
        @h.each do |_, aeth|
            html += aeth.to_table(type)
        end

        return html

    end

    def to_letters sentence, type

        l = letters
        roots = ['k', 'x', 's']
        medians = ['t', 'd', 'l']
        opposites = ['p', 'b', 'v']
        html = "<span class='septambres-#{type}'>"

        index = 0
        words = sentence.split(" ")
        words.each do |word|
           word.scan(/([ktpxdbslv][iao])/) do |aeths|
                aeths.each {|aeth| html += l[aeth] }
           end
           index += 1
           html += index < words.length ? " " : ""
        end

        html += "</span>"
        return html

    end

    def to_adultspeak sentence

        adultspeak = ""
        words = sentence.split(" ")
        words.each do |word|

            aeth_count = 0
            added = false

            # Regex for finding traumae aeths followed by punctuation.
            # Ignore stuff in quotes:
            # https://stackoverflow.com/questions/6462578/alternative-to-regex-match-all-instances-not-inside-quotes
            word.scan(/"[^"]+"|([ktpxdbslv][iao])(\.{3,3}|[\!\?\.])?/i) do |aeth|
                next if aeth[0].nil?

                if aeth_count == 0
                    adultspeak += aeth[0]
                elsif aeth_count == 1
                    adultspeak += aeth[0].reverse
                else
                    throw "Malformed sentence. Word count is #{aeth_count} and the word is #{word}"
                end

                aeth_count += 1
                added = true

                if aeth[1]
                    aeth_count = 0
                    adultspeak += aeth[1]
                end
            end

            adultspeak += word unless added
            adultspeak += " "

        end

        return adultspeak
    end

end