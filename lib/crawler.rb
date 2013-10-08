require_relative 'request'
require_relative 'parser'


class Crawler
	attr_accessor :url, :max_pages, :depth, :links

	def initialize
		@current_page = 0
	end

	def self.crawls(url, max_pages = 50, depth = 3)
		cralwer = Crawler.new
		cralwer.url = url
		cralwer.max_pages = max_pages
		cralwer.depth = depth
		cralwer.links = [url]
		cralwer
	end

	def calculate_inputs(url = @url, current_page = @current_page, current_depth = 0 )
		@current_page += 1
		values = []
		req = Request.request(url)
		if req['code'] == '200'
			parse = Parser.parse(req['body'], {:host => @url})
			path = URI(url).path == "" ? '/index.html' : URI(url).path
			if @current_page >= @max_pages || current_depth + 1 >= @depth
				return [path, parse.inputs.length]
			end
			if parse.links.length > 0
				z = []
				sum = 0
				@thread = []
				parse.links.each do |link|
					next if @links.include?(link)
					@links << link
					@thread << Thread.new do 
						val = calculate_inputs(link, @current_page, current_depth + 1)
						if val
							z << val
							if val[0].class == Array
								sum += val[0][1]
							else
								sum += val[1]
							end
						end
					end
					@thread.each {|t| t.join }
				end
				return [path, parse.inputs.length + sum, z]
			else
				return [path, parse.inputs.length]
			end
		end
	end
end