require 'spec_helper'

describe Request do 
	describe '#get_info' do 
		before do 
			GoogleDrive.stub(:login_with_oauth).and_return(google_drive_session)
		end

		it 'makes a GET request and reads the info of the request' do 
			req = described_class.request("http://www.google.com")
			expect(req.code).to eq 200
			expect(req.body).to eq "<head></head>"
		end
	end
end