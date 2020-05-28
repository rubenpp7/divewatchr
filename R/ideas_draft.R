


#.........................................................


## MAYBE IDEAS FOR LATER
#.........................................................


##### ANIMATED PLOTS  

# libraries:
library(ggplot2)
library(gganimate)
library(babynames)
library(hrbrthemes)

# Keep only 3 names
don <- babynames %>% 
  filter(name %in% c("Ashley", "Patricia", "Helen")) %>%
  filter(sex=="F")

# Plot
don %>%
  ggplot( aes(x=year, y=n, group=name, color=name)) +
  geom_line() +
  geom_point() +
  ggtitle("Popularity of American names in the previous 30 years") +
  theme_ipsum() +
  ylab("Number of babies born") +
  transition_reveal(year)



# Save at gif: does 
anim_save("287-smooth-animation-with-tweenr.gif")



#--------------------------------------------------------------
#                            OR
#--------------------------------------------------------------


#https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/






#Grafico de acumulada de numero de buceos

#------------------------------------------------------------

# Polygons with Label as formula and custom label options
leaflet(cities) %>% addTiles() %>%
  addCircles(lng = ~Long, lat = ~Lat, weight = 1,
             radius = ~sqrt(Pop) * 30, label = ~City,
             labelOptions = lapply(1:nrow(cities), function(x) {
               labelOptions(opacity = 0.8)
             }))
#' <br/><br/>

#--------------------------------------------------------------
## https://stackoverflow.com/questions/32940617/change-color-of-leaflet-marker

# Icons libraries 
# fa - https://fontawesome.com/v4.7.0/icons/
# glyphicon - https://getbootstrap.com/docs/3.3/components/
# ionicicons - https://ionicons.com/



mutate(scuba_map, group = cut(as.numeric(scuba_map$maximumDepthInMeters) , breaks = c(5, 10, 15, 20, 25, 30, Inf), labels = c("pink", "lightblue", "blue", "cadetblue", "darkblue", "darkpurple"))) -> mydf

### I edit this png file and created my own marker.
### https://raw.githubusercontent.com/lvoogdt/Leaflet.awesome-markers/master/dist/images/markers-soft.png
scubaIcons <- awesomeIconList(pink = makeAwesomeIcon(icon= 'cloud', markerColor = 'pink', iconColor = 'black'),
                              lightblue = makeAwesomeIcon(icon= 'cloud', markerColor = 'lightblue', iconColor = 'black'),
                              blue = makeAwesomeIcon(icon= 'cloud', markerColor = 'blue', iconColor = 'black'),
                              cadetblue = makeAwesomeIcon(icon= 'cloud', markerColor = 'cadetblue', iconColor = 'black'),
                              darkblue = makeAwesomeIcon(icon= 'cloud', markerColor = 'darkblue', iconColor = 'black'),
                              darkpurple = makeAwesomeIcon(icon= 'cloud', markerColor = 'darkpurple', iconColor = 'black'))


scubaIcons

leaflet(data = mydf[1:100,]) %>% 
  addTiles() %>%
  addMarkers(icon = ~scubaIcons$group)



icon.glyphicon <- makeAwesomeIcon(icon= 'cloud', markerColor = 'red', iconColor = 'black')
icon.fa <- makeAwesomeIcon(icon = 'flag', markerColor = 'mediumorchid1', library='fa', iconColor = 'black')
icon.ion <- makeAwesomeIcon(icon = 'home', markerColor = 'green', library='ion')



library(dplyr)
library(leaflet)



data(quakes)

# Show first 20 rows from the `quakes` dataset
leaflet(data = quakes[1:100,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag))

#___________________________________________________________

mutate(quakes, group = cut(mag, breaks = c(0, 5, 6, Inf), labels = c("blue", "green", "orange"))) -> mydf

### I edit this png file and created my own marker.
### https://raw.githubusercontent.com/lvoogdt/Leaflet.awesome-markers/master/dist/images/markers-soft.png
quakeIcons <- iconList(blue = makeIcon("./image_example_map.png", iconWidth = 24, iconHeight =32),
                       green = makeIcon("./image_example_map.png", iconWidth = 30, iconHeight =50),
                       orange = makeIcon("./image_example_map.png", iconWidth = 12, iconHeight =20))


leaflet(data = mydf[1:100,]) %>% 
  addTiles() %>%
  addMarkers(icon = ~quakeIcons[group])




# Marker + Label
leaflet() %>% addTiles() %>%
  addAwesomeMarkers(
    lng=-118.456554, lat=34.078039,
    label='This is a label',
    icon = icon.glyphicon)

leaflet() %>% addTiles() %>%
  addAwesomeMarkers(
    lng=-118.456554, lat=34.078039,
    label='This is a label',
    icon = icon.fa)

leaflet() %>% addTiles() %>%
  addAwesomeMarkers(
    lng=-118.456554, lat=34.078039,
    label='This is a label',
    icon = icon.ion)

# Marker + Static Label using custom label options
leaflet() %>% addTiles() %>%
  addAwesomeMarkers(
    lng=-118.456554, lat=34.078039,
    label='This is a static label',
    labelOptions = labelOptions(noHide = T),
    icon = icon.fa)
