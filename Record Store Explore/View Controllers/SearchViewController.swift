//
//  SearchViewController.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 17-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let storeSegueIdentifier = "ShowStoresSegue"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == storeSegueIdentifier,
            let destination = segue.destination as? StoreViewController {
            destination.searchQuery = searchInput.text!
        }
    }
}
