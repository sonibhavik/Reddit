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
    @IBAction func contentPolicyTapped(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://www.redditinc.com/policies/content-policy")! as URL)
    }
    @IBAction func privacyPolicyTapped(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://www.redditinc.com/policies/privacy-policy")! as URL)
    }
    @IBAction func userAgreementTapped(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://www.redditinc.com/policies/user-agreement")! as URL)
    }
    @IBAction func helpFaqTapped(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://www.reddithelp.com/en/categories/reddit-apps/reddit-ios-app?utm_source=share&utm_medium=ios_app")! as URL)
    }
    @IBAction func reportABugTapped(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://www.reddithelp.com/en/submit-request/mobile-help?utm_source=share&utm_medium=ios_app")! as URL)
    }
    func getVersion() -> String{
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[kVersion] as! String
        return "You are using Reddit \(String(describing: version))"
    }

    

}
