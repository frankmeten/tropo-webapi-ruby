require 'tropo-webapi-ruby'
require 'sinatra'

post '/index.json' do

  t = Tropo::Generator.new
  
  t.call :to => "+14071234321redf",
         :machineDetection => {
           :introduction => "This is just a test to see if you are a human or a machine. PLease hold while we determine. Almost finished. Thank you!",
           :voice => "Victor"
         }
  
  t.on :event => 'continue', :next => '/continue.json'
  
  headers \
      "webapiversion"   => "ruby-frank",
      "rubyversion"   => "ruby 2.4.0p0 (2016-12-24 revision 57164) [x86_64-darwin16]"
      
  "This is t.response, where is t.response"
  t.response
    
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