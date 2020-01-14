require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative 'helpers'

def get_data(url)

    url = URI(url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)


    response = http.request(request)
    JSON.parse(response.read_body)

end

clean_data = get_data("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=kvF0EyI3cJnKgMTh8H1V71gUVOCIODPYzNSnZztq")

File.open('index.html', 'w') do |f|
    f.puts header


x = clean_data['photos'].map{|x| x['img_src']}

f.puts "<img src='#{x}' alt=''>"
    
end     
f.puts footer
