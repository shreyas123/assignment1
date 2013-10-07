require 'nokogiri'

class Parser

	def initialize(content, options = {})
		@content = content
		@host = options[:host] || 'http://localhost/'
		@links = []
		@inputs = []
	end

	def self.parse(content, options = {})
		parser = Parser.new(content, options)
		parser
	end

	def links
		document.search("//a[@href]").each do |a|
        	u = a['href']
        	next if u.nil? or u.empty?
        	u = check(u)
        	@links << u unless u.nil?
      	end
      	@links.uniq
	end

	def inputs
		document.search("//input").each do |input|
			@inputs << input
		end
		@inputs.uniq
	end

	private 

	def document
		@document ||= Nokogiri::HTML(@content)
	end

	def check(link)
		if link.start_with?("/") || link.start_with?("#")
			url = URI.join(@host, link)
		else
			url = URI.parse(link)
			url = URI.parse("http://#{link}") if url.scheme.nil?
		end

		if url.host == URI(@host).host && url.path != ""
			url.to_s
		else
			nil
		end
	end
end