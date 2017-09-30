require_relative "../../vessel.oscean/objects/index.rb"
class Documentation

    HEADINGS = ["*", "="]

    def initialize path

        @h = Memory_Hash.new("documentation", path).to_h
        @index = Index.new

    end

    def to_s

        html = ""
        @h.each do |heading, paragraphs|
            if heading == "SOURCES" then next end
            parent = nil
            html += @index.add(:root, heading.downcase.to_sym)
            paragraphs.each do |p|
                print p[0, 1], HEADINGS[0]
                if p[0, 1] == HEADINGS[0]
                    parent = p[1..-1]
                    @index.add(heading.downcase.to_sym, parent)
                elsif p[0, 1] == HEADINGS[2] && !parent.nil?
                    @index.add(parent.trim.downcase.to_sym, p[1..-1])
                end
            end

            html += paragraphs.runes

        end

        print @index.inspect
        return @index.to_s(true) + html

    end

end