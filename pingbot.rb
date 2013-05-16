#!/usr/bin/env ruby

networkprefix = '192.168.0'

def pingable?(addr)
  output = `ping -c 1 #{addr}`
  !output.include? "100% packet loss"
end

host = 1
255.times do
  puts "#{networkprefix}.#{host} " + (pingable?("#{networkprefix}.#{host}") ? "up" : "down")
  oct += 1
end
