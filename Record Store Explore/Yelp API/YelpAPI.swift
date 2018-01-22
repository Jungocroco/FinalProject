
import YelpAPI
import BrightFutures

// Fill in your app keys here from
// https://www.yelp.com/developers/v3/manage_app
let appId = "wntKe-kJiSPMD5eHU1WJWw"
let appSecret = "9vzzzClQliLIZofh1q2o2SlsMt4wRWSIdutGlGkq4OgvxXjeTTgpMK3im1HW8pSj"
let API_KEY = "vl9W1irp8G-jgrC3jrWBw3AesCT34L3DA32XRXgQ1v9OPXtXAnRvKXY3VL_xILPrUiU-Zzoqelb2Sw1K0cSmkHm"


// Search for 3 dinner restaurants
let query = YLPQuery(location: "San Francisco, CA")
query.term = "dinner"
query.limit = 3

YLPClient.authorize(withAppId: appId, secret: appSecret, API_KEY: API_KEY).flatMap { client in
  client.search(withQuery: query)
}.onSuccess { search in
  if let topBusiness = search.businesses.first {
    print("Top business: \(topBusiness.name), id: \(topBusiness.identifier)")
  } else {
    print("No businesses found")
  }
  exit(EXIT_SUCCESS)
}.onFailure { error in
  print("Search errored: \(error)")
  exit(EXIT_FAILURE)
}

dispatchMain()

business.Search(withQuery: "Thai")

business.Search(withQuery)
