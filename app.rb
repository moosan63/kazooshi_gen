# app.rb
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
STORE_DIR = File.dirname(__FILE__).to_s + "/public/images/store/"

get '/' do
  @token = create_token()
  session[:token] = @token
  erb :index
end

post '/create' do

  #csrf対策
  if (params["token"] == session[:token]) && params[:file]
    #アップロードされたファイルをまず保存
    begin
      save_file = STORE_DIR+File.extname(params[:file][:filename])
      File.open(save_file, 'wb'){ |f| f.write(params[:file][:tempfile].read) }
    rescue
      puts "file write error"
      return 
    end
    #合成
    @image = composite(save_file, params["token"])
    @msg = ""
  else
    @msg = "select your image file!"
    @image = ""
  end
  erb :create
end

#画像を2枚重ね合わせるメソッド
private
def composite(src_file_name, result_file_name)
  begin
    resultFileName = STORE_DIR + result_file_name + ".png"
    
    result = Image.from_blob(File.read(STORE_DIR+"../kazoo_origin_bg.png")).shift.resize(256,256)
    img = Image.from_blob(File.read(src_file_name)).shift.resize(256,256)
    result = result.composite(img, 0, 0, OverCompositeOp)
    
    result.write(resultFileName)
    return "images/store/"+result_file_name+".png"
  rescue
    puts "file composite error"
    return ""
  end
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
