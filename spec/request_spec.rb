require 'spec_helper'

class Net::HTTPSuccess
	def body 
		"<head></head>"
	end
	def message 
		"OK"
	end
end

describe Request do 
	describe '#get_info' do 
		before do 
			Net::HTTP.stub(:get_response).and_return(Net::HTTPSuccess.new('OK', '200', true))
		end

		it 'makes a GET request and reads the info of the request' do 
			req = described_class.request("http://www.google.com")
			expect(req['code']).to eq "200"
			expect(req['body']).to eq "<head></head>"
		end

		describe 'redirection' do 
			before do 
				Net::HTTP.stub(:get_response).and_return(Net::HTTPRedirection.new('OK', '301', true))
				Net::HTTP.stub(:get_response).with(URI('http://www.google.com/123')).and_return Net::HTTPSuccess.new('OK', '200', true)
				Net::HTTPRedirection.any_instance.stub(:[]).and_return('http://www.google.com/123')
			end

			it 'redirects to the required location and make a HTTP request' do 
				req = described_class.request("http://www.google.com")
				Net::HTTP.should have_received(:get_response).with URI('http://www.google.com')
			end
		end
	end
end