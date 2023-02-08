### Zak Kaufman
### 2/8/23
### This will be an attempt to analyze Newcastle United's 
### player's market trends and specifically the effect the 
### new owners had on the market value.

# I am using free data found from https://data.world/dcereijo/player-scores

# added ggplot2 library
library(ggplot2)


# making a newcastle subset of teams
newcastle_players <- players[players$current_club_name == "Newcastle United", ]

# creating a player evaluations subset of just newcastle players
newcastle_player_valuations <- player_valuations[player_valuations$current_club_id == 762, ]

##adding a column for time using a numerical value in nufc valuations
newcastle_player_valuations$total_time <- as.numeric(substring(newcastle_player_valuations$date, 1,4))+
  as.numeric(substring(newcastle_player_valuations$date,6,7))/12 +
  as.numeric(substring(newcastle_player_valuations$date,9,10))/365

# add player names to player valuations using mutate()


# plot newcastle players as time has gone on by their valuation 
ggplot(newcastle_player_valuations[newcastle_player_valuations$total_time > 2015,], 
       aes(total_time, market_value_in_eur/1000000, 
           color = factor(newcastle_players$name[match(player_id, newcastle_players$player_id)])))+
  geom_point(alpha = .5)

