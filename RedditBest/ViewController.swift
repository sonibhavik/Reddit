//
//  ViewController.swift
//  RedditBest
//
//  Created by Bhavik Soni on 18/06/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var license: UILabel!
    
    
    @IBOutlet weak var licenseText: UITextView!
    @IBAction func accept(_ sender: Any) {
    }
    @IBAction func reject(_ sender: Any) {
        exit(0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
