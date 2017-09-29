require_relative "../../vessel.oscean/objects/index.rb"
class Documentation

    RUNES = ['$', '#']

    def initialize path

        @h = Memory_Hash.new("documentation", path).to_h
        @index = Index.new

    end

    def to_s

        html = ""
        @h.each do |heading, paragraphs|
            if heading == "SOURCES" then next end

            html += @index.add(:root, heading.downcase.to_sym)
            paragraphs.each do |p|
                rune, spell = get_rune(p)

                if rune
                    html += cast_spell(rune, spell, heading)
                else
                    html += "<p>#{p}</p>"
                end
            end
        end

        return @index.to_s(true) + html
    end

    def get_rune s

        rune = s[0, 1]
        spell = s[1..-1]
        if RUNES.include? rune
            return rune, spell
        else
            return nil
        end

    end

    def cast_spell rune, spell, heading = nil

        result = ""
        case rune
        when "$"
            result += $nataniev.answer(spell)
        when "#"
            result += @index.add(heading.to_sym, spell.to_sym)
        end

        return result
    end
end