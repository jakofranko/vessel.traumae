class Ehrivevnv

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

    def to_table

        html = ""
        @h.each do |_, aeth|
            html += aeth.to_table
        end

        return html

    end

end