class Movie < ApplicationRecord
	validates :title, presence: true, uniqueness: true, length: {maximum: 20}
	validates :score, presence: true, numericality: true
	validates :summary, length: {maximum: 50}
	
	def self.import(file)
		CSV.foreach(file.path, headers: true, encoding: 'BOM|UTF-8') do |row|
			# unless there is, new
			movie = find_by(title: row['title']) || new
			movie.attributes = row.to_hash.slice(*Movie.column_names)
			movie.updated_at = Time.now
			movie.save
		end
	end
  
	def self.updatable_attributes
		['mode', 'title', 'score', 'summary']
	end

  def self.mode_options
		['Movie', 'TV Series', 'DreamWorks']
	end
end
