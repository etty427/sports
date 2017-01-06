//
//  WebviewVC.swift
//  sportsNews
//
//  Created by Etnuh on 1/6/17.
//  Copyright © 2017 Rainman Technologies. All rights reserved.
//

import UIKit

class WebviewVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }

}
