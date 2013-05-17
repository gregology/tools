#!/usr/bin/env ruby
require 'socket'
require 'ipaddr'

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

def hostname?(addr)
  nslookup = `nslookup #{addr}`
  name =  nslookup.match(/can\'t find/i) ? 'UNKNOWN' : nslookup.split(/name\s\=\s/)[-1].gsub(/\.\n|\n/, '')
end

networkprefix = local_ip.gsub( (/\.\d$|\.\d\d$|\.\d\d\d$/), '' ).to_s

iplist = Hash.new {|hash,key| hash[key] = nil }
host = 1
256.times do
  ip = IPAddr.new("#{networkprefix}.#{host}").to_i
  iplist[ip] = { 'status' => (pingable?(ip) ? "yes" : "no"), 'hostname' => hostname?(ip)}
  host += 1
end

puts iplist.inspect
