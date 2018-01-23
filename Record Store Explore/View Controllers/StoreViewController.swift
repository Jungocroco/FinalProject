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
    
    let appId = "wntKe-kJiSPMD5eHU1WJWw"
    let appSecret = "9vzzzClQliLIZofh1q2o2SlsMt4wRWSIdutGlGkq4OgvxXjeTTgpMK3im1HW8pSj"
    var searchQuery = ""
    
    var businesses: [YLPBusiness]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

        // Search for 3 dinner restaurants
        let query = YLPQuery(location: searchQuery)
        query.term = "vinyl records"
        
        YLPClient.authorize(withAppId: appId, secret: appSecret) { (client, error) in
            client!.search(with: query, completionHandler: {(search, error)
                in
                self.businesses = search!.businesses
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                for business in search!.businesses{
                    print(business.name)
                    print(business.location.address.first!)
                }
            })}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = self.businesses[indexPath.row]
        
        return cell
    }

    let mapSegueIdentifier = "ShowMapsSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == mapSegueIdentifier,
            let destination = segue.destination as? MapViewController,
            let storeIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.storeLatitude = (businesses[storeIndex].location.coordinate?.latitude)!
            destination.storeLongitude = (businesses[storeIndex].location.coordinate?.longitude)!
            destination.storeName = (businesses[storeIndex].name)
            destination.storeAddress = (businesses[storeIndex].location.address.first)!
            destination.storeArray = businesses
        }
    }
    
}

