#!/bin/env ruby
# encoding: utf-8

$nataniev.require("corpse","http")

$nataniev.vessels[:traumae].name = "Traumae"
$nataniev.vessels[:traumae].docs = "A synthetic language, the ancestor of [Lietal](wiki.xxiivv.com/lietal)"
$nataniev.vessels[:traumae].site = "wiki.xxiivv.com/traumae"
$nataniev.vessels[:traumae].path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

# Install actions
load_folder("#{$nataniev.vessels[:traumae].path}/actions/*")
$nataniev.vessels[:traumae].install(:generic,:document)
$nataniev.vessels[:traumae].install(:generic,:print)
$nataniev.vessels[:traumae].install(:custom,:test)

corpse = CorpseHttp.new($nataniev.vessels[:traumae])

$nataniev.vessels[:traumae].corpse = corpse

def corpse.aebeth ; return @aebeth; end
def corpse.dictionaery ; return @dictionaery; end

def corpse.query query = nil

  params = query.split(" ")
  q = params[0]

  load_folder "#{$nataniev.vessels[:traumae].path}/objects/*"

  # @dictionaery = Dictionaery.new($nataniev.vessels[:traumae].path)
  @aebeth = Aebeth.new($nataniev.vessels[:traumae].path)
  @ehrivevnv = Ehrivevnv.new($nataniev.vessels[:traumae].path)

  if q.like("aebeth")
    @payload = @aebeth.to_table
    return
  end

  if q.like("ehrivevnv")
    alt = params[1] || nil
    @payload = @ehrivevnv.to_table(alt)
    return
  end

  if q.like("septambres")
    type = params[1] || nil
    @payload = @aebeth.to_table(type)
    return
  end

  if q.like("sentence")
    sentence = params[2..-1].join(" ")
    case params[1]
    when "ehrivevnv"
        @payload = @ehrivevnv.to_letters(sentence)
    when "ehrivevnv_alt"
        @payload = @ehrivevnv.to_letters(sentence, "alt")
    when "ehrivevnv_july"
        @payload = @ehrivevnv.to_letters(sentence, "july")
    when "septambres_neau"
        @payload = @ehrivevnv.to_letters(sentence, "neau")
    when "septambres_lith"
        @payload = @ehrivevnv.to_letters(sentence, "lith")
    when "septambres_fune"
        @payload = @ehrivevnv.to_letters(sentence, "fune")
    when "septambres_recit"
        @payload = @aebeth.to_letters(sentence, "recit")
    end
    return
  end

  if q.like("adultspeak")
    sentence = params[1..-1].join(" ")
    @payload = @aebeth.to_adultspeak(sentence)
    return
  end

  if q.like("documentation")
    documentation = Documentation.new($nataniev.vessels[:traumae].path)
    # documentation.dictionaery = @dictionaery
    @payload = documentation.to_s
    return
  end

  if q.like("dictionaery")
    @payload = @dictionaery.to_s
    return
  end

  if q.split(" ").first.like("side_by_side")
    file_name = q.split(" ").last.downcase
    @payload = @dictionaery.side_by_side_large(file_name)
    return
  end

  @payload = "missing"

end