require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative 'helpers'

def get_data (url)

    url = URI(url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)


    response = http.request(request)
    JSON.parse(response.read_body)
end

clean_data = get_data("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=kvF0EyI3cJnKgMTh8H1V71gUVOCIODPYzNSnZztq")
puts clean_data

File.open('index.html' , 'w') do |n|
        n.puts header
        clean_data.each do |hash_info|
        n.puts "<img src='#{hash_info['url']}' alt='#{hash_info['title']}'>"
        end
        n.puts footer
    end 