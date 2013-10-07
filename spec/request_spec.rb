require 'spec_helper'

class Net::HTTPSuccess
	def body 
		"<head></head>"
	end
end

describe Request do 
	describe '#get_info' do 
		before do 
			Net::HTTP.stub(:get_response).and_return(Net::HTTPSuccess.new('OK', '200', true))
		end

		it 'makes a GET request and reads the info of the request' do 
			req = described_class.request("http://www.google.com")
			expect(req.code).to eq "200"
			expect(req.body).to eq "<head></head>"
		end
	end
end