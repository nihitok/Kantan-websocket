#coding:utf-8
require 'em-websocket'

Process.daemon(nochdir=true) if ARGV[0] == "-D"
connections = Array.new

EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 51234) do |ws|
  ws.onopen {
    ws.send "繋がった〜(❍ʻ◡ʻ❍) "
    connections.push(ws) unless connections.index(ws)
  }
  ws.onmessage { |msg|
    puts "received "+msg
    ws.send msg #to myself
    connections.each {|con|
      #to other people
      con.send(msg) unless con == ws
    }
  }
  ws.onclose   { puts "閉じます〜" }
end
