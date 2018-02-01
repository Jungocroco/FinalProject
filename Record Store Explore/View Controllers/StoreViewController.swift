//
//  ViewController.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 11-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

import UIKit
import YelpAPI
import BrightFutures

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

class StoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // lets & vars
    let appId = "wntKe-kJiSPMD5eHU1WJWw"
    let appSecret = "9vzzzClQliLIZofh1q2o2SlsMt4wRWSIdutGlGkq4OgvxXjeTTgpMK3im1HW8pSj"
    let mapSegueIdentifier = "ShowMapsSegue"
    var searchQuery = ""
    var businesses: [YLPBusiness]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview configuration
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

        let query = YLPQuery(location: searchQuery)
        query.term = "vinyl records"
        
        // Yelp API Authorization & Search
        YLPClient.authorize(withAppId: appId, secret: appSecret) { (client, error) in
            client?.search(with: query, completionHandler: {(search, error)
                in
                if search != nil {
                    self.businesses = search?.businesses
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                } else if search == nil {
                    // Alert pop-up initialization
                    let alertController = UIAlertController(title: "There's a slight problem", message:
                        "No stores to show..", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            })}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // row configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    // cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = self.businesses[indexPath.row]
        
        return cell
    }
    
    // segue information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == mapSegueIdentifier,
            let destination = segue.destination as? MapViewController,
            let storeIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.storeLatitude = (businesses[storeIndex].location.coordinate?.latitude)!
            destination.storeLongitude = (businesses[storeIndex].location.coordinate?.longitude)!
            destination.storeArray = businesses
            destination.storeSite = String(describing: businesses[storeIndex].url)
        }
    }
    
}

