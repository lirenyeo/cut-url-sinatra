class Url < ActiveRecord::Base
	validates :long_url, presence: true,
	format: { with: /\A(http|https|ftp):\/\/.*/}

	validates :short_url, uniqueness: true

	before_create :shorten

	def shorten
		# 'http://' << ([*('a'..'z'),*('A'..'Z'),*('0'..'9')]-%w(0 1 I O)).sample(8).join
		self.short_url = SecureRandom.hex(6)
	end
end