//
//  WebKitViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 4/27/22.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let googleURL = URL(string: "https://www.google.com")
    
    // MARK: google 
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlRequest = URLRequest(url: googleURL!)
        webView.load(urlRequest)
    }
    
    // MARK: swipe gesture
    @IBAction func swipeGesture(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }


}
