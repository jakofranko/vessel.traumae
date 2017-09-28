require_relative "../../vessel.oscean/objects/index.rb"
class Documentation

   def initialize path

       @h = Memory_Hash.new("documentation", path).to_h
        print @h.inspect
   end

   def to_s

        index = Index.new
        html = ""
        @h.each do |heading, paragraphs|
            if heading == "SOURCES" then next end

            html += index.add(:root, heading.downcase.to_sym)
            paragraphs.each do |p|
                # TODO: handle runes
                html += "<p>#{p}</p>"
            end
        end

        print index.inspect
        return index.to_s(true) + html
   end

   def rune s

       return s[0, 1]

   end

end