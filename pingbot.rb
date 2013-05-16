#!/usr/bin/env ruby
require 'socket'

def local_ip
  orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

  UDPSocket.open do |s|
    s.connect '64.233.187.99', 1
    s.addr.last
  end
ensure
  Socket.do_not_reverse_lookup = orig
end

def pingable?(addr)
  output = `ping -c 1 #{addr}`
  !output.include? "100% packet loss"
end

networkprefix = local_ip.gsub( (/\.\d$|\.\d\d$|\.\d\d\d$/), '' ).to_s

host = 1
255.times do
  puts "#{networkprefix}.#{host} " + (pingable?("#{networkprefix}.#{host}") ? "up" : "down")
  host += 1
end
