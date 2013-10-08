require 'net/http'
class Request

	def initialize(url)
		@url = url
	end

	def self.request(url)
		req = Request.new(url)
		response = req.fetch(url)
		return {'code' => response.code, 'body' => response.body }
	end

	def fetch(uri_str, limit = 10)
		# You should choose a better exception.
		return Error.new('400', 'too many redirects') if limit == 0

		begin

			response = Net::HTTP.get_response(URI(uri_str))
		rescue
			return Error.new('400', 'too many redirects')
		end

		case response
			when Net::HTTPSuccess then
				response
			when Net::HTTPRedirection then
				location = response['location']
				fetch(location, limit - 1)
			else
				response
		end
	end

end

class Error
	attr_accessor :code, :body
	def initialize(code, message)
		@code = code
		@body = body
	end
end