//
//  ViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 2/16/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: double tap gesture
    @IBAction func tapGesture(_ sender: Any) {
        performSegue(withIdentifier: "startStudying", sender: nil)
    }
    
}

