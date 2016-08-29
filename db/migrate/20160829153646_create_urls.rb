class CreateUrls < ActiveRecord::Migration
	def change
		create_table :urls do |t|
			t.text :short_url
			t.text :long_url

	    	t.timestamps
	    end
	end
end
