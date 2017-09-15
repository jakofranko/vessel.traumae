#!/bin/env ruby
# encoding: utf-8

$nataniev.require("corpse","http")

$nataniev.vessels[:traumae].path = File.expand_path(File.join(File.dirname(__FILE__), "/"))
$nataniev.vessels[:traumae].install(:custom,:print)

corpse = CorpseBase.new($nataniev.vessels[:traumae])

$nataniev.vessels[:traumae].corpse = corpse

def corpse.aebeth ; return @aebeth; end
def corpse.dictionaery ; return @dictionaery; end

def corpse.query q = nil

  load_folder "#{$nataniev.vessels[:traumae].path}/objects/*"

  @dictionaery = Dictionaery.new($nataniev.vessels[:traumae].path)
  @aebeth = Aebeth.new($nataniev.vessels[:traumae].path)

  if q.like("documentation")
    documentation = Documentation.new($nataniev.vessels[:traumae].path)
    documentation.dictionaery = @dictionaery
    documentation.aebeth = @aebeth
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