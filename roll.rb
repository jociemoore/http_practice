require "socket"

server = TCPServer.new("localhost", 3003)
loop do 
  client = server.accept

  request_line = client.gets
  puts request_line

  # GET /?rolls=2&sides=6 HTTP/1.1
  url_parts = request_line.split

  http_method = url_parts[0]
  path = url_parts[1].split('?')[0]
  params = url_parts[1].split('?')[1].split('&').map { |part| part.split('=') }.to_h

  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params
  params["rolls"].to_i.times do 
    client.puts rand(params["sides"].to_i) + 1
  end
  client.close
end