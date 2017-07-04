#require 'tropo-webapi-ruby'
require '/Users/xiangjyu/git/tropo-webapi-ruby/lib/tropo-webapi-ruby/tropo-webapi-ruby.rb'
require 'sinatra'

post '/index.json' do

  t = Tropo::Generator.new
  
  t.say("Please hold while we transfer your call")
  
  whisper = [{
    :event => "connect",
    :ask => {
      :say => {:value => "Press 1 to accept this call or any other key to decline"},
      :choices => {:value => "1", :mode => "dtmf"},
      :name => "transfer",
      :interdigitTimeout => 1
    },
    :event => "connect",
    :say => {:value => "You are now being connected to the transfer"}
  }]
  #pppppppquts whisper
  
  t.transfer :to => "+14071234321",
             :on => whisper

  t.on :event => 'incomplete', :next => '/hangup.json', :say => {:value =>'You have opted out from accepting this call. Goodbye'}
  
  t.response
  headers \
      "Allow"   => "BREW, POST, GET, PROPFIND, WHEN",
      "Refresh" => "Refresh: 20; http://www.ietf.org/rfc/rfc2324.txt"
    
end

post '/hangup.json' do
  t = Tropo::Generator.new

  t.hangup
  t.response

end