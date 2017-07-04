#require 'tropo-webapi-ruby'
require '/Users/xiangjyu/git/tropo-webapi-ruby/lib/tropo-webapi-ruby/tropo-webapi-ruby.rb'
require 'sinatra'

post '/index.json' do

  t = Tropo::Generator.new
  
  #t.call :to => "sip:xiangjun_yu@192.168.26.1:5678"
  #t.call :to => "sip:frank@172.16.22.128:5678"
  t.call :to => ["sip:frank@172.16.22.128:5678","sip:xiangjun_yu@192.168.26.1:5678"],#:promptLogSecurity => "supp5resss",
    :timeout => 21,:machineDetection =>{:introduction=> "i am introduction test",:voice=>"en-us"},
    :headers => "gffdddddddddddddd"
  #t.sa505y :value => "Guess what? http://www.phono.com/audio/holdmusic.mp3"
  t.sa505y :value => "Success!"
  t.on :next => "document2.json",
    :event => "continue"
  
  headers \
      "WebAPI-Lang-Ver"   => "ruby-frank20170628",
      "rubyversion"   => "ruby 2.4.0p0 (2016-12-24 revision 57164) [x86_64-darwin16]"
      
  "This is t.response, where is t.response"
  t.response # def response  line 464
    
end


post '/continue.json' do
  
  v = Tropo::Generator.parse request.env["rack.input"].read
  t = Tropo::Generator.new
  #pppppppquts v
  userType = v[:result][:user_type]
  #pppppppquts userType
  t.say(:value => "You are a  #{userType}")
  
  t.response
  
end