require 'net/http'
class Request

	def initialize(url)
		@url = url
	end

	def self.request(url)
		req = Request.new(url)
		response = req.fetch(url)
		response
	end

	def fetch(uri_str, limit = 10)
		# You should choose a better exception.
		return 'too many HTTP redirects' if limit == 0

		response = Net::HTTP.get_response(URI(uri_str))

		case response
			when Net::HTTPSuccess then
				response
			when Net::HTTPRedirection then
				location = response['location']
				warn "redirected to #{location}"
				fetch(location, limit - 1)
			else
				response
		end
	end

end