# coding:utf-8
$LOAD_PATH << File.dirname(File.dirname(__FILE__))
require 'spec_helper'
require 'app'


describe 'GET /' do
    before :all do
        get '/'
    end

    it "statusコードは200である" do
        last_response.ok?.should be_true
    end
end

describe 'POST /create' do
    before :all do
        post '/create'
        @token = create_token
    end

    it 'statusコードは200である' do
        last_response.ok?.should be_true
    end
end

describe 'create_token()' do
    def create_token()
        token =''
        a =->(){  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|e| e.to_a }.flatten.sample }
        (1..16).each do
            token += a.()
        end        
        return token
    end

    before :all do
        @token = create_token
    end
    
    it '長さは16である' do
        @token.length == 16
    end

    it '繰り返すと違うものになる' do
        10.times do 
           @token.should_not == create_token
        end
    end
end

describe 'composite(src,dst)' do
    STORE_DIR = File.dirname(File.dirname(__FILE__)).to_s + "/spec/images/"
    def composite(src_file_name, result_file_name)
        begin
            resultFileName = STORE_DIR + result_file_name + ".png"
            result = Image.from_blob(File.read(STORE_DIR+"kazoo_origin_bg.png")).shift.resize(256,256)
            img = Image.from_blob(File.read(STORE_DIR+src_file_name+".png")).shift.resize(256,256)

            result = result.composite(img, 0, 0, OverCompositeOp)            
            result.write(resultFileName)

            return resultFileName
        rescue
            return ""
        end
    end

    it '格納場所はSTORE_DIRである' do
        STORE_DIR.should == "/Users/moosan/Development/kazooshi_gen/spec/images/"
    end

    it 'srcに存在するファイルを入力しないと空文字列が帰ってくる' do
        composite("empty.png","result").should == "" 
    end

    it 'srcに存在するファイルを入力すると格納場所のurlが帰ってくる' do
        composite("quco","result").should =~/result.png/ 
    end
end
