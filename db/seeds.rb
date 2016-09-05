

values = File.read('db/urls')

Url.transaction do
	Url.connection.execute "INSERT INTO urls (long_url) VALUES #{values}"
end