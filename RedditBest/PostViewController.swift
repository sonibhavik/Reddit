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
    init(authorName: String, postTitle: String, postTime: String) {
        self.authorName = authorName
        self.postTitle = postTitle
        self.postTime = postTime
    }
}
class TableCell: UITableViewCell {
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postTime: UILabel!
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
    let authorName = Expression<String>("name")
    let postTitle =  Expression<String>("emial")
    let postTime = Expression<String>("city")
    let usersTable = Table("uSer6")
    var db : Connection!
    var accessToken: Any = ""
    var posts = [Post]()
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            switch response.result {
                case .success:
                    print("Validation Successful :)")
                    if let json = response.data {
                        do{
                            let data = try JSON(data: json)
                            let actualData = data["data"]["children"]
                            for i in 0...9{
                                    let authorName = String(describing: actualData[i]["data"]["author"])
                                    let title = String(describing: actualData[i]["data"]["title"])
                                    self.name = String(describing: actualData[i]["data"]["name"])
                                    let time = String(describing: actualData[i]["data"]["created_utc"])
                                    let epocTime = TimeInterval(time)!
                                    let unixTimestamp = NSDate(timeIntervalSince1970: epocTime)
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "dd MMMM yyyy HH:MM:SS"
                                    formatter.timeZone = NSTimeZone.local
                                    let updatedTime = formatter.string(from: unixTimestamp as Date)
                                    let post = Post(authorName: authorName, postTitle: title, postTime: updatedTime)
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
        cell.authorName.text = post.authorName
        cell.postTitle.text = post.postTitle
        cell.postTime.text = post.postTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == posts.count - 1 {
            self.loadDataFromApi()
        }
    }
}
