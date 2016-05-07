class Contact < ActiveRecord::Base
	self.primary_key = "id"

	has_attached_file :photo, styles: {medium: "500x500>",thumb:"100x100>"}

	validates_attachment_content_type :photo,
		:content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
		
	def self.search_by_name(query)
		result = []
		if query[0].strip != "" 
			contacts = Contact.all
				if query
					query = query.split(' ')
					contacts.each do|c|
						if c.field_company
							if queryExists(query,c.name) and not result.include?(c)
								result.append c
							end
						end
				end
			end
		end
		return result
	end

	def self.search_by_field_company(query)
		result = []
		if query[0].strip != "" 
			contacts = Contact.all
			query = query.split(' ')
			contacts.each do|c|
					if c.field_company
						if queryExists(query,c.field_company) and not result.include?(c)
							result.append c
						end
				end
			end
		end
		return result
	end
	def self.search_guest_all(query)
		result = []
		if query[0].strip != "" 
			contacts = Contact.all
			query = query.split(' ')
			contacts.each do|c|
					if c.field_company
						if queryExists(query,c.field_company+c.name) and not result.include?(c)
							result.append c
						end
				end
			end
		end
		return result
	end



	def self.search_in_all(query)
		result = []
		if query[0].strip != "" 
			contacts = Contact.all
			if query
				query = query.split(' ')
				contacts.each do|c|
					result.append c if queryExists(query,c.inspect) and not result.include?(c)
				end
				result
			end
		end
	result
	end

	private 
	def self.queryExists (query,string)
		query.each do |q|
			if  not string.downcase.include?(q.downcase)
				return false
			end
		end
		return true
	end



end
