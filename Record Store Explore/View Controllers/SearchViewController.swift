//
//  SearchViewController.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 17-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let storeSegueIdentifier = "ShowStoresSegue"
    
    // outlet & action
    @IBOutlet weak var searchInput: UITextField!
    @IBAction func SearchFieldPrimaryActionTriggered(_ sender: Any) {
        performSegue(withIdentifier: storeSegueIdentifier, sender: Any?.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // segue information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == storeSegueIdentifier,
            let destination = segue.destination as? StoreViewController {
            destination.searchQuery = searchInput.text!
        }
    }
}
