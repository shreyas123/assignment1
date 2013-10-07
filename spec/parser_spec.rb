require 'spec_helper'

describe Parser do 
	describe '#parse' do 
		it 'should assigns the content body' do 
		 	parser = Parser.parse('hi', { :host => 'http://www.example.com' })
			expect(parser.instance_variable_get(:@content)).to eq 'hi'
		end
	end

	describe '#links' do 
		it 'returns the links in the total site' do 
			parser = Parser.parse("<head><a href='/index.html'></a></head>")
			expect(parser.links.length).to eq 1
		end

		it 'retuns the uniq and only ones which points to current host' do 
			parser = Parser.parse("<head>
				<a href='/index.html'></a>
				<a href='http://www.google.com/abcd.html'></a>
				<a href='www.google.com/abcd123.html'></a>
				<a href='#'></a>
				</head>", {:host => 'http://www.abcd.com'}
			)
			expect(parser.links).to eq ["http://www.abcd.com/index.html"]
		end

		it 'returns uniq links present in the page' do 
			parser = Parser.parse("<head>
				<a href='/index.html'></a>
				<a href='/index.html'></a>
				<a href='http://www.google.com/abcd.html'></a>
				<a href='www.google.com/abcd123.html'></a>
				<a href='#'></a>
				</head>", {:host => 'http://www.abcd.com'}
			)
			expect(parser.links).to eq ["http://www.abcd.com/index.html"]
		end
	end

	describe '#inputs' do 
		it 'returns the input in the page' do 
			parser = Parser.parse("<head>
				<input type='text'/>
				<input type='radio'/>
				<input type='button'/>
				<input type='checkbox' />
				input is a pain
				</head>")
			expect(parser.inputs.length).to eq 4
		end
	end
end
