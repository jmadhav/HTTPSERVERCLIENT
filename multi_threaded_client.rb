#!/usr/bin/env ruby
require 'rubygems'
require 'net/http'
require 'uri'

threads = []
t1 = Time.now
puts "Starting Client Requests ========>>> #{t1}"
(0..1)each do |d|
  thread = Thread.new d do |c|
    client = "Client"+ d.to_s 
    #p client
    uri = URI("http://localhost:4567/daemon_response?client=#{client}")
    
    Net::HTTP.start(uri.host, uri.port) do |http|
      #p "URI ==> #{uri.inspect} "
      #p " URI REQUEST URI==> #{uri.request_uri}"
      request = Net::HTTP::Get.new uri.request_uri
      http.request request do |response| # Net::HTTPResponse object
        response.read_body do |chunk|
          puts client+" Got Response =>"
          puts chunk
        end
      end
      http.finish()
    end
    
  end
  sleep 1
  threads << thread
end
threads.each {|t| t.join}
t2 = Time.now
puts "#########################################"
puts "Total Time Taken"
puts "#{t2 -t1}"
puts "##########################################"
