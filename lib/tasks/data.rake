desc "Download team list from MFL and update leagues and teams tables"
task :populate_teams => :environment do

	mfl_year = "2021"

	response = Faraday.get \
		"https://www65.myfantasyleague.com/#{mfl_year}/export?TYPE=league&L=" \
		"#{Rails.application.credentials.justice_la_liga[:league_id]}&JSON=1&APIKEY=" \
		"#{Rails.application.credentials.justice_la_liga[:api_key]}"

	mfl_league_id = JSON.parse(response.body)["league"]["id"]

	valid_positions = []

	JSON.parse(response.body)["league"]["starters"]["position"].each do |position|
		valid_positions.push(position["name"])
	end

	formatted_league = JSON.parse(response.body)["league"]

	league_attrs = {
		mfl_id: "#{formatted_league["id"]}",
		name: "#{formatted_league["name"]}",
		salary_cap: "#{formatted_league["salaryCapAmount"]}",
		base_url: "#{formatted_league["baseURL"]}",
		player_positions: valid_positions
	}

	League.upsert(league_attrs, unique_by: :league_mfl_id)

	formatted_teams = JSON.parse(response.body)["league"]["franchises"]["franchise"]

	team_attrs = formatted_teams.map do |team|
		{
			mfl_league_id: "#{mfl_league_id}",
			mfl_year: 		 "#{mfl_year}",
			mfl_id: 			 "#{team["id"]}",
			name: 				 "#{team["name"]}",
			owner_name: 	 "#{team["owner_name"]}"
		}
	end

	Team.upsert_all(team_attrs, unique_by: :team_mfl_id)
end

desc "Download player list from MFL and update players table"
task :populate_players => :environment do

	mfl_year = "2021"

	response = Faraday.get "https://api.myfantasyleague.com/#{mfl_year}/export?TYPE=players&JSON=1"

	formatted_players = JSON.parse(response.body)["players"]["player"]

	player_attrs = formatted_players.map do |player|
		{
			mfl_id: 					"#{player["id"]}",
			position: 				"#{player["position"]}",
			name: 						"#{player["name"]}",
			team: 						"#{player["team"]}",
			mfl_team_id: 			nil,
			salary: 					nil,
			years_remaining: 	nil,
			status: 					nil,
			ytd_score: 				nil
		}
	end

	Player.upsert_all(
		player_attrs,
		update_only: [:position, :name, :team],
		unique_by: :player_mfl_id
	)
end

desc "Download contract data and update players table"
task :populate_contracts => :environment do

	mfl_year = "2021"
	mfl_league_id = "63949"

	response = Faraday.get \
		"https://www65.myfantasyleague.com/#{mfl_year}/export?TYPE=rosters&L=#{mfl_league_id}" \
		"&APIKEY=#{Rails.application.credentials.justice_la_liga[:api_key]}&JSON=1"

	formatted_rosters = JSON.parse(response.body)["rosters"]["franchise"]

	contract_attrs = formatted_rosters.map do |roster|
		team_id = "#{roster["id"]}"
		roster["player"].map do |player|
			{
				mfl_id: "#{player["id"]}",
				mfl_team_id: "#{team_id}",
				salary: "#{player["salary"]}".to_f,
				years_remaining: "#{player["contractYear"]}",
				status: "#{player["status"]}"
			}
		end
	end

	Player.upsert_all(
		contract_attrs.flatten,
		unique_by: :player_mfl_id,
		update_only: [:mfl_team_id, :salary, :years_remaining, :status]
	)

end

desc "Update players with YTD scoring"
task :populate_scores => :environment do

	mfl_year = "2021"
	mfl_league_id = "63949"

	response = Faraday.get "https://www65.myfantasyleague.com/" \
		"#{mfl_year}/export?TYPE=playerScores&L=#{mfl_league_id}&W=YTD&RULES=1" \
		"&APIKEY=#{Rails.application.credentials.justice_la_liga[:api_key]}&JSON=1"

	formatted_scores = JSON.parse(response.body)["playerScores"]["playerScore"]

	formatted_scores.each do |player|
		a_player = Player.find_by(mfl_id: player["id"])
		a_player.ytd_score = player["score"]
		a_player.save
	end
end
