require './lib/crawler'

print 'Please enter a website to crawl:'

website = gets.chomp

c = Crawler.crawls(website)

z = c.calculate_inputs()

def print_out(val, dash = 0)
	val.each do |val1|
		
		dash.times { print "-" }
		print " "

		print "#{val1[0]} #{val1[1]}"
		puts ""
		
		if val1[2] && Array === val1[2]
			print_out(val1[2], dash + 3)
		end
	end
end

print_out([z])

