module TagsHelper
	def min_salary(player_current_salary, players_array)
		player_salaries = []
		players_array.each do |player| player_salaries.push(player[1]) end
		minimum_raise = player_salaries.sum / player_salaries.size * 1.2
		[player_current_salary * 1.2, minimum_raise].max
	end
end
