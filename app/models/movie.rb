class Movie < ApplicationRecord
	validates :title, presence: true, uniqueness: true, length: {maximum: 20}
	validates :score, presence: true, numericality: true
	validates :summary, length: {maximum: 50}
	
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			puts "#{row['mode']} #{row['title']} #{row['score']} #{row['summary']}"
			# unless there is, new
			movie = find_by(title: row['title']) || new
			movie.attributes = row.to_hash.slice(*updatable_attributes)
			movie.created_at, movie.updated_at = Time.now, Time.now
			movie.save
		end
	end
	
	def self.updatable_attributes
		['mode', 'title', 'score', 'summary']
	end
end
