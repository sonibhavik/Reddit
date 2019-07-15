//
//  SettingsViewController.swift
//  RedditBest
//
//  Created by Bhavik Soni on 15/07/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let kVersion = "CFBundleShortVersionString"
    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = getVersion()
        // Do any additional setup after loading the view.
    }
    func getVersion() -> String{
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[kVersion] as! String
        return "You are using Reddit \(String(describing: version))"
    }

    

}
