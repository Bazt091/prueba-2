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

clean_data.to_hash
puts clean_data['photos'].map{|x| x['img_src']}

File.open('index.html', 'w') do |f|
    f.puts header
    f.puts '<ul>'
    clean_data.map do |data|
        
            # puts data['photos']['img_src']
     

        
f.puts footer
    end
end
