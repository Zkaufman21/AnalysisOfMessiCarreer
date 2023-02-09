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
#newcastle_player_valuations <- player_valuations[player_valuations$current_club_id == 762, ]
#newcastle_player_valuations <- filter(player_valuations, match(player_valuations$player_id, newcastle_players$player_id, nomatch = -1) != -1)

# adding a column for time using a numerical value in nufc valuations
player_valuations$total_time <- as.numeric(substring(player_valuations$date, 1,4))+
  as.numeric(substring(player_valuations$date,6,7))/12 +
  as.numeric(substring(player_valuations$date,9,10))/365

# removing irrelevant players to this data by eliminating players who were not on the team at to 05/30/2022
relevant_newcastle_players <- newcastle_players[newcastle_players$last_season >2021, ]

# plot newcastle players as time has gone on by their valuation 
relevant_year_cutoff <- 2020

#takeover date for easy use
nufc_takeover_date <- 2021.852

whole_nufc_team_scatterplot<- ggplot(player_valuations[player_valuations$total_time > relevant_year_cutoff,], 
       aes(total_time, market_value_in_eur/1000000, 
           color = factor(relevant_newcastle_players$name[match(player_id, 
                                                                relevant_newcastle_players$player_id)])))+
 # geom_point(alpha = .5)+ # makes point semi see through
  geom_line()+ # connects the data points
  scale_colour_discrete(na.translate = F)+  # removes na vals
  xlim(2020,2023)+ # sets x scale
  ylim(0,75)+ # sets y scale 
  geom_vline(xintercept =  nufc_takeover_date, # adding line for takeover date 
             color = "#cc0000",
             lwd = 1,
             linetype = "dashed")+
  annotate("text",
           x = nufc_takeover_date + .05,
           y = 68,
           label = "Takeover Date",
           size = 3.5,
           angle = 90)

whole_nufc_team_scatterplot + labs(title = "Relevant Newcastle Players Market Value Growth",
                                     color = "Players",
                                     x = "Date (Takeover Occured Oct 7, 2021)",
                                     y = "Market Value (Millions of Euros")

