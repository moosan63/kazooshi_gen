# coding: utf-8
require 'rubygems'
require 'sinatra'
require 'json'
require 'RMagick'
include Magick

#== sinatra session
enable :sessions
configure do
    use Rack::Session::Cookie,
    #:key => 'rack.session',
    #:domain => 'foo.com',
    #:path => '/',
    :expire_after => 3600,
    :secret => 'change'
end
####################
#   sinatraな部分  #
#################### 

get '/' do
  @token = create_token()
  session[:token] = @token
  erb :index
end

post '/create' do
    #csrf対策
    if params["token"] == session[:token]
    end
end

#画像を2枚重ね合わせるメソッド
private
def composite(src_file_name, result_file_name)
    resultFileName = "./images/"+file_name

    result = Image.from_blob(File.read("./images/kazoo_origin_bg.png")).shift.resize(128,128)
    img = Image.from_blob(File.read("./images/"+src_file_name)).shift.resize(128,128)
    result = result.composite(img, 0, 0, OverCompositeOp)

    result.write(resultFileName)
end

#連続投稿を防ぐためのトークンを作成する
private
def create_token
    token =''
    a =->(){  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|e| e.to_a }.flatten.sample }
    (1..16).each do
        token += a.()
    end
    return token
end
