//
//  PostViewController.swift
//  RedditBest
//
//  Created by Bhavik Soni on 18/06/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//
import Alamofire
import SwiftUI
import OAuthSwift
import SQLite
import SwiftyJSON
import Combine

class Post: Decodable{
    let authorName: String
    let postTitle: String
    let postTime: String
    let subreddit_name_prefixed: String
    let commentsCount : String
    let ups: String
    init(authorName: String, postTitle: String, postTime: String, subreddit_name_prefixed: String, commentsCount : String, ups: String) {
        self.authorName = authorName
        self.postTitle = postTitle
        self.postTime = postTime
        self.subreddit_name_prefixed = subreddit_name_prefixed
        self.commentsCount = commentsCount
        self.ups = ups
    }
}
class TableCell: UITableViewCell {
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var subReddit: UILabel!
    @IBOutlet weak var Comment: UILabel!
    @IBOutlet weak var Ups: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var accessToken: Any = ""
    var posts = [Post]()
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        self.navigationItem.setHidesBackButton(true, animated: false)
        getAccessToken()
     }
    func getAccessToken(){
        
        guard let url = URL(string: "https://www.reddit.com/api/v1/access_token") else { return }
        let  uuid : String = UIDevice.current.identifierForVendor!.uuidString
        let parameter: Parameters = ["grant_type" : "https://oauth.reddit.com/grants/installed_client", "device_id" : "\(uuid)"]
        let username = "EWiVjM0cjxliNw"
        let password = ""
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)! as NSData
        let base64EncodedString = loginData.base64EncodedString()
        let headers = ["Content-Type" : "application/x-www-form-urlencoded", "Authorization" : "Basic \(base64EncodedString)"]
        Alamofire.request(url, method: .post , parameters: parameter, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            switch response.result {
                case .success:
                    if let result = response.result.value {
                        let responseDict = result as! [String : Any]
                        self.accessToken = responseDict["access_token"]!
                        self.loadDataFromApi()
                    }
                case .failure(let error):
                    print(error)
                
           }
        }
     }
    

    
    func loadDataFromApi(){
        
        let token = "bearer \(self.accessToken)"
        let headers = ["Content-Type" : "application/x-www-form-urlencoded", "Authorization" : "\(token)"]
        guard let api_url = URL(string: "https://oauth.reddit.com/best") else { return }
        let parameter: Parameters =  ["show": "","after": "\(name)", "limit": 10]
        Alamofire.request(api_url, method: .get ,parameters: parameter, headers: headers).validate().responseJSON { (response) in
            print(response)
            switch response.result {
                case .success:
                    print("Validation Successful :)")
                    if let json = response.data {
                        do{
                            let data = try JSON(data: json)
                            let actualData = data["data"]["children"]
                            for i in 0...9{
                                    let author = String(describing: actualData[i]["data"]["author"])
                                    let authorName = ("posted by: u/\(author)")
                                    let title = String(describing: actualData[i]["data"]["title"])
                                    let subreddit_name_prefixed = String(describing: actualData[i]["data"]["subreddit_name_prefixed"])
                                    self.name = String(describing: actualData[i]["data"]["name"])
                                    let commentsCount = String(describing: actualData[i]["data"]["num_comments"])
                                    let ups = String(describing: actualData[i]["data"]["ups"])
                                    let time = String(describing: actualData[i]["data"]["created_utc"])
                                    let unixTimestamp = NSDate(timeIntervalSince1970: TimeInterval(time)!)
                                    let formatter = DateFormatter()
                                    let date = Date()
                                    let calendar = Calendar.current
                                    formatter.dateFormat = "MMM dd, yyyy HH:MM:SS"
                                    formatter.timeZone = NSTimeZone.local
                                    let components = calendar.dateComponents([.hour], from: unixTimestamp as Date, to: date)
                                    let diff = components.hour!
                                    let updatedTime = ("\u{2022}\(diff)h ago")
                                    let post = Post(authorName: authorName, postTitle: title, postTime: updatedTime, subreddit_name_prefixed: subreddit_name_prefixed, commentsCount: commentsCount, ups: ups)
                                    self.posts.append(post)
                                
                                }
                            OperationQueue.main.addOperation ({
                                self.tableView.reloadData()
                            })
                        }catch{
                            print("JSON Error")
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        let post = posts[indexPath.row]
        cell.subReddit.text = post.subreddit_name_prefixed
        cell.authorName.text = post.authorName
        cell.postTitle.text = post.postTitle
        cell.postTime.text = post.postTime
        cell.Comment.text = post.commentsCount
        cell.Ups.text = post.ups
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == posts.count - 1 {
                self.loadDataFromApi()
        }
    }
}
