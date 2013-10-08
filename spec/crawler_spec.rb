require 'spec_helper'

describe Crawler do 
	describe 'initializes' do 
		it 'initializes URL, depth and Limit' do 
			c = Crawler.crawls('http://www.google.com')
			expect(c.depth).to eq 3
			expect(c.max_pages).to eq 50
			expect(c.url).to eq 'http://www.google.com'
			expect(c.links).to eq ['http://www.google.com']
		end
	end

	describe 'calculate inputs' do 
		describe 'with only 1 link' do 
			before do 
				Request.stub(:request).and_return({'code' => '200', 'body' => '<head><input/></head>'})
			end
			it 'returns the total of inputs in the page' do 
				c = Crawler.crawls('http://www.google.com')
				expect(c.calculate_inputs).to eq ['/index.html', 1]
			end
		end

		describe 'with 1 level deep' do 
			before do 
				one_link_content = File.read(File.join(File.dirname(__FILE__) ,'fixtures', 'one_link.html'))
				Request.stub(:request).with('http://www.google.com').and_return({'code' => '200', 'body' => one_link_content})

				product_content = File.read(File.join(File.dirname(__FILE__) ,'fixtures', 'product.html'))
				Request.stub(:request).with('http://www.google.com/product.html').and_return({'code' => '200', 'body' => product_content})
			end

			it 'returns the total of inputs in the page' do 
				c = Crawler.crawls('http://www.google.com')
				expect(c.calculate_inputs).to eq ['/index.html', 2 , [['/product.html', 1]]]
			end
		end
	end
end