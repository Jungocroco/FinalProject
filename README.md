# FinalProject
Timo den Hartog

8-1-18

Record Store Explore

1. Problem statement.
2. Solution.
3. Prerequisites.

Problem statement.

For the lack of an app that combines record store locations and assortment, this is it. Record stores often don't care that much about their websites and focus on the physical stores. They mostly outsource their online sales to Discogs. To locate record stores and instantly discover their goods at the same time within one app makes for a more efficient digging session. As a result one can decide to visit the physical shop and route to it or to let it be.


Solution.

The goal is to create a all-in-one record store finder.
Main features:
- Map with record stores shown
- Yelp Guide with the default settings of record stores
- Discogs assortment and prices per shop
- (possibly) Price comparing


Prerequisites.

Data sources:
- Google Maps API, https://developers.google.com/maps/
- Yelp, https://www.yelp.nl/developers/documentation/v3/business_search
 - Data may have to be transformed before usable
- Discogs, https://www.discogs.com/developers/#page:marketplace
  - Data may have to be transformed before usable
  
External components:
- Firebase Authentication & Database
  - https://firebase.google.com/products/auth/
  - https://firebase.google.com/products/realtime-database/

Review of similar mobile apps:
There is no specifically similar app to what i propose. The Marketplace section of the Discogs app links to a browser and is thereby not implemented in the app itself. The Yelp app only shows reviews and locations, no assortment or goods to be bought.

Hardest part identification:
The combination of these different API's into one map-centered application looks like the biggest struggle to overcome. Also, retrieving Discogs' data and presenting it in a user-friendly way can become a difficulty.
