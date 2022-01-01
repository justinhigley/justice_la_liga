desc "Download team list from MFL and update teams table"
task :populate_teams => :environment do

	mfl_year = "2021"

	response = Faraday.get \
		"https://www65.myfantasyleague.com/#{mfl_year}/export?TYPE=league&L=" \
		"#{Rails.application.credentials.justice_la_liga[:league_id]}&JSON=1&APIKEY=" \
		"#{Rails.application.credentials.justice_la_liga[:api_key]}"

	mfl_league_id = JSON.parse(response.body)["league"]["id"]

	formatted_teams = JSON.parse(response.body)["league"]["franchises"]["franchise"]

	team_attrs = formatted_teams.map do |team|
		{
			mfl_league_id: "#{mfl_league_id}",
			mfl_year: "#{mfl_year}",
			mfl_id: "#{team["id"]}",
			name: "#{team["name"]}",
			owner_name: "#{team["owner_name"]}"
		}
	end

	Team.upsert_all(team_attrs, unique_by: :teams_upsert_index)

end

desc "Download player list from MFL and update players table"
task :populate_players => :environment do

	mfl_year = "2021"

	response = Faraday.get "https://api.myfantasyleague.com/#{mfl_year}/export?TYPE=players&JSON=1"

	formatted_players = JSON.parse(response.body)["players"]["player"]

	player_attrs = formatted_players.map do |player|
		{
			mfl_id: "#{player["id"]}",
			position: "#{player["position"]}",
			name: "#{player["name"]}",
			team: "#{player["team"]}"
		}
	end

	Player.upsert_all(player_attrs, unique_by: :mfl_id)

end

desc "Download contract list from MFL and update contracts table"
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
				mfl_team_id: "#{team_id}",
				mfl_player_id: "#{player["id"]}",
				mfl_league_id: "#{mfl_league_id}",
				salary: "#{player["salary"]}".to_f,
				years_remaining: "#{player["contractYear"]}",
				status: "#{player["status"]}"
			}
		end
	end

	Contract.upsert_all(contract_attrs.flatten, unique_by: :contracts_upsert_index)

end