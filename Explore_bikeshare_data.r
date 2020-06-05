
ny = read.csv('new_york_city.csv')
wash = read.csv('washington.csv')
chi = read.csv('chicago.csv')

head(ny)

names(ny)

dim(ny)

head(wash)

names(wash)

dim(wash)

head(chi)

names(chi)

dim(chi)

ny$city <- c(rep('ny',times=dim(ny)[1]))
head(ny)

wash$city <- c(rep('wash',times=dim(wash)[1]))
chi$city <- c(rep('chi',times=dim(chi)[1]))

cities <- merge(merge(ny,wash,by=names(wash),all=TRUE),chi,by=names(chi),all=TRUE)
head(cities)

tail(cities)

dim(cities)[1] == dim(ny)[1]+dim(wash)[1]+dim(chi)[1]

table(cities$city)

table(cities$User.Type)

library(ggplot2)

ggplot(aes(x=User.Type), data=subset(cities,User.Type!='')) +
  geom_bar(color='black', fill='#F79420',
           width=0.3, position=position_dodge(width=0.3)) +
  labs(x='Motivate user types', y='Number of trips',
       title='Trips and types of Motivate users in NYC, Chicago and Washington,D.C.') +
  coord_flip() +
  theme_light()

ggplot(aes(x=User.Type), data=subset(cities,User.Type!='')) +
  geom_bar(color='black', fill='#099DD9') +
  facet_wrap(~city) +
  labs(x='Motivate user types', y='Number of trips taken',
       title='Trips and types of Motivate users in NYC, Chicago and Washington,D.C.') +
  theme_light()

ggplot(aes(city,fill=User.Type), data=subset(cities,User.Type!='')) +
  geom_bar(position="fill", color='black') +
  scale_fill_brewer(palette='Blues') +
  labs(x='Motivate city of operation', y='Share of trips taken',
       title='Trips and types of Motivate users in NYC, Chicago and Washington,D.C.') +
  theme_light()

ggplot(aes(city,fill=User.Type), data=subset(cities,User.Type!='')) +
  geom_bar(position="fill", color='black') +
  scale_fill_brewer(palette='Blues') +
  labs(x='Motivate city of operation', y='Share of trips taken',
       title='Trips and types of Motivate users in NYC, Chicago and Washington,D.C.',
       fill='Motivate\nUser Type') +
  theme_light() +
  theme(panel.grid.major.x = element_blank()
        )

by(cities$User.Type,cities$city,summary)

summary(cities$Trip.Duration)

ggplot(aes(x=Trip.Duration/60),
       data=subset(cities,!is.na(Trip.Duration))) +
  geom_histogram(binwidth=15
                 ,color='black') +
  theme_light()

ggplot(aes(x=Trip.Duration/60),
       data=subset(cities,!is.na(Trip.Duration))) +
  geom_histogram(binwidth=15
                 ,color='black') +
  scale_x_continuous(breaks=seq(0,12*60,60),limits = c(0,12*60)) +
  theme_light()

ggplot(aes(x=Trip.Duration/3600),
       data=subset(cities,!is.na(Trip.Duration))) +
  geom_histogram(binwidth=0.25
                 ,color='black'
                 ,fill='#099DD9') +
  scale_x_continuous(breaks=seq(0,4,0.5),limits = c(0,4)) +
  labs(x='Trip duration (hours)', y='Number of trips',
       title='Distribution of Motivate trip durations') +
  theme_light()

summary(cities$Trip.Duration/60)

summary(cities$Trip.Duration/3600)

ggplot(aes(x=Trip.Duration/3600,y=..density..),
       data=subset(cities,!is.na(Trip.Duration))) +
  geom_histogram(binwidth=0.25
                 ,color='black'
                 ,fill='#099DD9') +
  facet_wrap(~city,ncol=1) +
  scale_x_continuous(breaks=seq(0,4,0.5),limits = c(0,4)) +
  labs(x='Trip duration (hours)', y='Trip density',
       title='Distribution of Motivate trip durations in Chicago, DC and NYC') +
  theme_light()

by(cities$Trip.Duration/60,cities$city,summary)

ggplot(aes(x=Trip.Duration/3600,y=..density..),
       data=subset(cities,!is.na(Trip.Duration) & User.Type!='')) +
  geom_histogram(binwidth=0.25
                 ,color='black'
                 ,fill='#099DD9') +
  facet_grid(city~User.Type) +
  scale_x_continuous(breaks=seq(0,4,0.5),limits = c(0,4)) +
  labs(x='Trip duration (hours)', y='Trip density',
       title='Distribution of Motivate trip durations by user type in Chicago, DC and NYC') +
  theme_light()

by(cities$Trip.Duration/60,cities$User.Type,summary)

summary(cities$Birth.Year)

ggplot(aes(x=Birth.Year),
       data=subset(cities,!is.na(Birth.Year) & city!='wash')) +
  geom_histogram(binwidth=1
                 ,color='black'
                 ,fill='#099DD9') +
  theme_light() 

ggplot(aes(y=Birth.Year,x=city),
       data=subset(cities,!is.na(Birth.Year) & city!='wash')) +
  geom_boxplot() +
  theme_light()

by(cities$Birth.Year,cities$city,summary)

ggplot(aes(y=Birth.Year,x=city),
       data=subset(cities,!is.na(Birth.Year) & city!='wash')) +
  geom_boxplot(
        # custom boxes
        color="black",
        fill="#099DD9",
        alpha=0.2,
        # Notch
        notch=TRUE,
        notchwidth = 0.8,
        # custom outliers
        outlier.colour="black",
        outlier.fill="black",
        outlier.size=3) +
  scale_y_continuous(breaks=seq(1950,2010,10)) +
  coord_cartesian(ylim=c(1950,2010)) +
  theme_light()

ggplot(aes(x=Birth.Year,y=Trip.Duration/3600)
       ,data=subset(cities,!is.na(Trip.Duration) & !is.na(Birth.Year) & city!='wash')) +
#scatter plot
  geom_point(alpha=.1,
             position=position_jitter(h=0),
             color='orange') +
#more parameters
  coord_cartesian(xlim=c(1950,2010),
                  ylim=c(0,4)) +
  scale_x_continuous(breaks=seq(1950,2010,10)) +
  scale_y_continuous(breaks=seq(0,4,0.5)) +
  theme_light()

ggplot(aes(x=Birth.Year,y=Trip.Duration/3600)
       ,data=subset(cities,!is.na(Trip.Duration) & !is.na(Birth.Year) & city!='wash')) +
#scatter plot
  geom_point(alpha=.05,
             position=position_jitter(h=0),
             color='orange') +
#summary lines
##mean
  geom_line(stat='summary',
            fun.y='mean') +
##10th quantile
  geom_line(stat='summary',
            fun.y='quantile',
            fun.args=list(probs=.1),
            linetype=2, #dashed
            color='blue') +
##median
  geom_line(stat='summary',
            fun.y='median',
            color='blue') +
##90th quantile
   geom_line(stat='summary',
            fun.y='quantile',
            fun.args=list(probs=.9),
            linetype=2, #dashed
            color='blue') +
#more parameters
  facet_grid(rows=vars(city)) +
  coord_cartesian(xlim=c(1950,2000),
                  ylim=c(0,2)) +
  scale_x_continuous(breaks=seq(1950,2000,10)) +
  scale_y_continuous(breaks=seq(0,2,0.5)) +
  labs(x='User year of birth', y='Trip duration (hours)',
       title='Trip duration and birth years of Motivate users in NYC and Chicago') +
  theme_light()

ggplot(aes(x=Birth.Year,y=Trip.Duration/3600)
       ,data=subset(cities,!is.na(Trip.Duration) & !is.na(Birth.Year) & city!='wash')) +
#scatter plot
  geom_point(alpha=.05,
             position=position_jitter(h=0),
             color='orange') +
#summary lines
##mean
  geom_line(stat='summary',
            fun.y='mean',
            aes(color='Mean',linetype='Mean')) +
##10th quantile
  geom_line(stat='summary',
            fun.y='quantile',
            fun.args=list(probs=.1),
            aes(color='10th pctile',linetype='10th pctile')) +
##median
  geom_line(stat='summary',
            fun.y='median',
            aes(color='Median',linetype='Median')) +
##90th quantile
   geom_line(stat='summary',
            fun.y='quantile',
            fun.args=list(probs=.9),
            aes(color='90th pctile',linetype='90th pctile')) +
#more parameters
  coord_cartesian(xlim=c(1950,2000),
                  ylim=c(0,2)) +
  scale_x_continuous(breaks=seq(1950,2000,10)) +
  scale_y_continuous(breaks=seq(0,2,0.5)) +
  labs(x='User year of birth', y='Trip duration (hours)',
       title='Trip duration and birth years of Motivate users in NYC and Chicago') +
  scale_linetype_manual(name="Statistics",values=c('Mean'=1,'10th pctile'=2,
                                                   'Median'=1,'90th pctile'=2)) +
  scale_color_manual(name="Statistics",values=c('Mean'='black','10th pctile'='blue',
                               'Median'='blue','90th pctile'='blue')) +
  theme_light()

system('python -m nbconvert Explore_bikeshare_data.ipynb')
