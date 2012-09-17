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
    before :all do
        @token =''
        a =->(){  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|e| e.to_a }.flatten.sample }
        (1..16).each do
            @token += a.()
        end        
    end

    #2個目を生成する
    before :each do
        @token2 =''
        a =->(){  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|e| e.to_a }.flatten.sample }
        (1..16).each do
            @token2 += a.()
        end        
    end
    
    it '長さは16である' do
        @token.length == 16
    end

    it '繰り返すと違うものになる' do
        @token.should_not == @token2 
    end
end
