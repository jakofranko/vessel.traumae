class Ehrivevnv

    attr_accessor :h

    def initialize path

        load_any(path, "ehriv_aeth")
        @h = Memory_Hash.new("ehrivevnv", path).to_h("ehriv_aeth")

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

    def to_table alt = nil

        html = ""
        @h.each do |_, aeth|
            html += aeth.to_table(alt)
        end

        return html

    end

    def to_letters sentence, alt = false

        html = "<span class='ehriv_aeth'>"
        words = sentence.split(" ")
        words.each do |word|
            word.scan(/([sxk][iea])([nm])?/i) do |root, cap|
                if !root.nil?
                    html += (cap == 'n') ? '-' : (cap == 'm') ? '+' : ''
                end
                html += alt ? @h[root.upcase].alt : @h[root.upcase].letter
            end
        end
        html += "</span>"
        return html

    end

end