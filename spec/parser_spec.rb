require 'spec_helper'

describe Parser do 
	describe '#parse' do 
		it 'should assigns the content body' do 
		 	parser = Parser.parse('hi')
			expect(parser.instance_variable_get(:@content)).to eq 'hi'
		end
	end

	describe '#links' do 
		it 'returns the links in the total site' do 
			parser = Parser.parse("<head><a href='/index.html'></a></head>")
			expect(parser.links).to eq ["/index.html"]
		end
	end
end
