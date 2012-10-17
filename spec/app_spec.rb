# coding:utf-8
$LOAD_PATH << File.dirname(File.dirname(__FILE__))
require 'spec_helper'
require 'app'


describe 'GET /' do
  before :all do
    get '/'
  end

  it { last_response.ok?.should be_true }
end

describe 'POST /create' do
  before :all do
    post '/create'
    @token = create_token
  end

  it { last_response.ok?.should be_true }
end

describe 'create_token()' do

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

  it '格納場所はSTORE_DIRである' do
    STORE_DIR.should == "/Users/moosan/Development/kazooshi_gen/public/images/store/"
  end

  it 'srcに存在するファイルを入力しないと空文字列が帰ってくる' do
    composite("empty.png","result").should == "" 
  end

end
