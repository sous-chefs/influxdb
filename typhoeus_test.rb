#/usr/bin/env ruby

require 'typhoeus'

request = Typhoeus::Request.new("https://google.com", followlocation: true, verbose: true)

request.run

request.on_complete do |resp|
  if response.success?
    puts "Hell Yeah"
  elsif response.timed_out?
    puts "Time out"
  elsif response.code == 0
    puts(response.return_message)
  else
    puts "HTTP request failed: #{response.code.to_s}"
  end
end
