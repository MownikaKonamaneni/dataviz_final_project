# Remove rows with empty values
worldcup_matches <- worldcup_matches[!is.na(worldcup_matches$Year), ]

# Convert the datetime column to a POSIXct object
worldcup_matches$Datetime <- as.POSIXct(worldcup_matches$Datetime, format = "%d %b %Y - %H:%M", tz = "UTC")
# Separate the datetime column into date and time
worldcup_matches$Date <- as.Date(worldcup_matches$Datetime)
worldcup_matches$Time <- format(worldcup_matches$Datetime, format = "%H:%M")

# Renaming specific column names for clarity
colnames(worldcup_matches)[6] <- "home_team_name"
colnames(worldcup_matches)[7] <- "home_team_goals"
colnames(worldcup_matches)[8] <- "away_team_goals"
colnames(worldcup_matches)[9] <- "away_team_name"
colnames(worldcup_matches)[10] <- "win_conditions"
colnames(worldcup_matches)[12] <- "half_time_home_goals"
colnames(worldcup_matches)[13] <- "half_time_away_goals"
colnames(worldcup_matches)[15] <- "assistant1"
colnames(worldcup_matches)[16] <- "assistant2"
colnames(worldcup_matches)[19] <- "home_team_initials"
colnames(worldcup_matches)[20] <- "away_team_initials"
colnames(worldcup_matches)

# Create the "Goals" column
worldcup_matches$Goals <- worldcup_matches$home_team_goals + worldcup_matches$away_team_goals

# Create the "Match Outcome" column
worldcup_matches$outcome <- ifelse(worldcup_matches$home_team_goals > worldcup_matches$away_team_goals, "Home Team Win", "Away Team Win")

# Calculate summary statistics
summary(worldcup_matches$home_team_goals)
summary(worldcup_matches$away_team_goals)

# Cleaning the dataset by replacing the old names of countries with current names
worldcup_matches = worldcup_matches %>% 
  mutate(home_country=case_when(home_team_name %like% 'China' ~ "China",
                                home_team_name=="C�te d'Ivoire" ~ 'Ivory Coast',
                                home_team_name %like% "Czech" ~ 'Czechia',
                                home_team_name=="England" ~ 'United Kingdom',
                                home_team_name=="Scotland" ~ 'United Kingdom',
                                home_team_name %like% "German" ~ 'Germany',
                                home_team_name %like% "Iran" ~ 'Iran',
                                home_team_name %like% "Korea DPR" ~ 'North Korea',
                                home_team_name %like% "Korea" ~ 'South Korea',
                                home_team_name %like% "Ireland" ~ 'Ireland',
                                home_team_name %like% "Serbia" ~ 'Republic of Serbia',
                                home_team_name %like% "Yugoslavia" ~ 'Republic of Serbia',
                                home_team_name %like% "Soviet Union" ~ 'Russia',
                                home_team_name %like% "USA" ~ 'United States of America',
                                home_team_name %like% "Wales" ~ 'United Kingdom',
                                home_team_name %like% "Zaire" ~ 'Republic of the Congo',
                                home_team_name %like% "Bosnia" ~ 'Bosnia and Herzegovina',
                                home_team_name %like% "Trinidad and Tobago" ~ "Trinidad and Tobago",
                                home_team_name %like% "United Arab Emirates" ~ "United Arab Emirates",
                                home_team_name %like% "Dutch East Indies" ~ "Indonesia",
                                TRUE ~ home_team_name),
         away_country=case_when(away_team_name %like% 'China' ~ "China",
                                away_team_name=="C�te d'Ivoire" ~ 'Ivory Coast',
                                away_team_name %like% "Czech" ~ 'Czechia',
                                away_team_name=="England" ~ 'United Kingdom',
                                away_team_name=="Scotland" ~ 'United Kingdom',
                                away_team_name %like% "German" ~ 'Germany',
                                away_team_name %like% "Iran" ~ 'Iran',
                                away_team_name %like% "Korea DPR" ~ 'North Korea',
                                away_team_name %like% "Korea" ~ 'South Korea',
                                away_team_name %like% "Ireland" ~ 'Ireland',
                                away_team_name %like% "Serbia" ~ 'Republic of Serbia',
                                away_team_name %like% "Yugoslavia" ~ 'Republic of Serbia',
                                away_team_name %like% "Soviet Union" ~ 'Russia',
                                away_team_name %like% "USA" ~ 'United States of America',
                                away_team_name %like% "Wales" ~ 'United Kingdom',
                                away_team_name %like% "Zaire" ~ 'Republic of the Congo',
                                away_team_name %like% "Bosnia" ~ 'Bosnia and Herzegovina',
                                away_team_name %like% "Trinidad and Tobago" ~ "Trinidad and Tobago",
                                away_team_name %like% "United Arab Emirates" ~ "United Arab Emirates",
                                away_team_name %like% "Dutch East Indies" ~ "Indonesia",
                                TRUE ~ away_team_name)
  )
