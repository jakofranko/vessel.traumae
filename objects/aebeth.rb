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

end