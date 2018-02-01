//
//  WebViewController.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 30-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // outlet & var for implemented Webview
    @IBOutlet weak var webView: WKWebView!
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
