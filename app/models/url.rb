class Url < ActiveRecord::Base
	def self.shorten
		# 'http://' << ([*('a'..'z'),*('A'..'Z'),*('0'..'9')]-%w(0 1 I O)).sample(8).join
		SecureRandom.hex(6)
	end

	def self.get_long

	end
end
