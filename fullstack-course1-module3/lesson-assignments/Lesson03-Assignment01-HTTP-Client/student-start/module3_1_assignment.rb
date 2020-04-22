require 'httparty'

class Recipe
	include HTTParty

	base_uri 'https://www.food2fork.com/api'
	default_params key: ENV["FOOD2FORK_KEY"]
	format :json

	def self.for keyword
		get("/search", query: {q: keyword})["recipes"]
	end
end
