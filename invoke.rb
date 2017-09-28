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

corpse = CorpseBase.new($nataniev.vessels[:traumae])

$nataniev.vessels[:traumae].corpse = corpse

def corpse.aebeth ; return @aebeth; end
def corpse.dictionaery ; return @dictionaery; end

def corpse.query q = nil

  load_folder "#{$nataniev.vessels[:traumae].path}/objects/*"

  @dictionaery = Dictionaery.new($nataniev.vessels[:traumae].path)
  @aebeth = Aebeth.new($nataniev.vessels[:traumae].path)

  if q.like("aebeth")
    @payload = @aebeth.list
    return
  end

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