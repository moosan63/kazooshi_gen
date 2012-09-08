# coding: utf-8
require 'sinatra'
require 'json'
require 'RMagick'
include Magick

#== sinatra session
enable :sessions
use Rack::Session::Cookie,
#:key => 'rack.session',
#:domain => 'foo.com',
#:path => '/',
:expire_after => 3600,
:secret => 'change'

####################
#   sinatraな部分  #
#################### 

get '/' do
  @token = create_token()
  session[:token] = @token
  erb :index
end

post '/create' do
end

private
def composite
    resultFileName = "./images/result.png"

    result = Image.from_blob(File.read("./images/kazoo_origin_bg.png")).shift.resize(128,128)
    img = Image.from_blob(File.read("./images/quco.png")).shift.resize(128,128)
    result = result.composite(img, 0, 0, OverCompositeOp)

    result.write(resultFileName)
end

private
def create_token
    token =''
    a =->(){  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|e| e.to_a }.flatten.sample }
    (1..16).each do
        token += a.()
    end
    return token
end
