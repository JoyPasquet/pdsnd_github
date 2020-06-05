**Date created**:
June 5th, 2020.

# Exploring Bikeshare Data

### Description
This project investigates bikeshare data from the [Motivate](https://www.motivateco.com/) bikeshare systems in 3 major US cities: Chicago, New York City, and Washington, D.C.

Three research questions were examined as part of this project, with the goal of practicing exploratory data analysis and visualization in R:
1. **Is there a prevailing type of users and how do the 3 cities compare in that regard?**
2. **What is travel time like for the 3 cities?**
3. **How do trip durations relate to birth year?**

### Files used
Data comes from 3 individual CSV files corresponding to each city: `chicago.csv`,`new_york_city.csv`,`washington.csv`.

The data includes a **cleaned, anonymized, randomly selected** subset of trip data from these cities for the first 6 months of 2017. All three of the data files contain the same core 6 columns:
* **Start Time** (e.g., *2017-01-01 00:07:57*)
* **End Time** (e.g., *2017-01-01 00:20:53*)
* **Trip Duration** (in seconds - e.g., *776*)
* **Start Station** (e.g., *Broadway & Barry Ave*)
* **End Station** (e.g., *Sedgwick St & North Ave*)
* **User Type** (*Subscriber* or *Customer*)

The Chicago and New York City files also have the following two columns:
* **Gender**
* **Birth Year**

### Credits
This project was conducted as part of the **Udacity Data Science with R Nanodegree Program**, and with the support of Udacity.
