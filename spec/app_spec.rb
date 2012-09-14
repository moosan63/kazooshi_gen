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
