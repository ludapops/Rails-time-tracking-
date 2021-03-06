class Project < ActiveRecord::Base
	has_many :entries
	validates :name, {uniqueness: true, presence: true, length: {maximum: 30}, format: {with: /\w/}}
	
	def self.iron_find(id)
		where(id: id).first
	end

	def self.clean_old(time)
		# where(update_at: id.)
		to_kill = where("updated_at < ?", time)
		to_kill.destroy_all
	end

	def self.last_created_projects(n)
		order(created_at: :desc).limit(n)
	end

	def monthly_work(month,year)
		date = DateTime.new(year, month)
		es = entries.where(date: date.beginning_of_month..date.end_of_month)
		hours = 0
		minutes = 0
		es.each do |entry| 
			hours += entry.hours
			minutes += entry.minutes
		end
		minutes/60 + hours
	end 
end


  		

