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

class Post{
    let authorName: String
    let postTitle: String
    let postTime: String
    let subreddit_name_prefixed: String
    let commentsCount : String
    let ups: String
    let link: String
    let image: String
    init(authorName: String, postTitle: String, postTime: String, subreddit_name_prefixed: String, commentsCount : String, ups: String, link: String, image: String) {
        self.authorName = authorName
        self.postTitle = postTitle
        self.postTime = postTime
        self.subreddit_name_prefixed = subreddit_name_prefixed
        self.commentsCount = commentsCount
        self.ups = ups
        self.link = link
        self.image = image
    }
}
class TableCell: UITableViewCell {
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var subReddit: UILabel!
    @IBOutlet weak var Comment: UITextField!
    @IBOutlet weak var Ups: UITextField!
    @IBOutlet weak var imagEView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let commentImage = UIImage(named: "comment")
        imageAdd(txtField: Comment, andImage: commentImage!)
        let arrowImage = UIImage(named: "arrow")
        imageAdd(txtField: Ups, andImage: arrowImage!)
        // Initialization code
    }
    func imageAdd(txtField: UITextField, andImage img: UIImage){
            let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
            leftImageView.image = img
            txtField.leftView = leftImageView
        txtField.leftViewMode = .always
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
    let imageLoader = ImageDownload()
//    var cache: NSCache<NSString, UIImage>! = NSCache()
//    typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        self.navigationItem.setHidesBackButton(true, animated: false)
        getAccessToken()
     }
    
//    func obtainImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
//        print("1")
//        if let image = self.cache.object(forKey: imagePath as NSString) {
//            print("2")
//            DispatchQueue.main.async {
//                completionHandler(image)
//            }
//        } else {
//            print("3")
//            let placeholder = UIImage(named: "images1")!
//            DispatchQueue.main.async {
//                completionHandler(placeholder)
//                print("4")
//            }
//            print("5")
//            Alamofire.request(imagePath).responseData { (response) in
//                if let data = response.result.value{
//                    do{
//                        print("he")
//                        let img: UIImage! = UIImage(data: data)
//                        self.cache.setObject(img, forKey: imagePath as NSString)
//                        DispatchQueue.main.async {
//                            completionHandler(img)
//                        }
//                        
//                    }
//                }
//            }.resume()
//        }
//    }
    
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
//            print(response)
            switch response.result {
                case .success:
                    print("Validation Successful :)")
                    if let json = response.data {
                        do{
                            let data = try JSON(data: json)
                            let actualData = data["data"]["children"]
                            for i in 0...9{
                                let author = String(describing: actualData[i]["data"]["author"])
                                let title = String(describing: actualData[i]["data"]["title"])
                                let thumbnail = String(describing: actualData[i]["data"]["thumbnail"])
//                                var image1 = UIImage()
//                                if let imageUrl = URL(string: thumbnail), let imageData = try? Data(contentsOf: imageUrl) {
//                                    image1 = UIImage(data: imageData)!
//                                 }
                                let subreddit_name_prefixed = String(describing: actualData[i]["data"]["subreddit_name_prefixed"])
                                self.name = String(describing: actualData[i]["data"]["name"])
                                let commentsCount = String(describing: actualData[i]["data"]["num_comments"])
                                let ups = String(describing: actualData[i]["data"]["ups"])
                                let link = String(describing: actualData[i]["data"]["permalink"])
                                let time = String(describing: actualData[i]["data"]["created_utc"])
                                let unixTimestamp = NSDate(timeIntervalSince1970: TimeInterval(time)!)
                                let formatter = DateFormatter()
                                let date = Date()
                                let calendar = Calendar.current
                                formatter.dateFormat = "MMM dd, yyyy HH:MM:SS"
                                formatter.timeZone = NSTimeZone.local
                                let components = calendar.dateComponents([.hour], from: unixTimestamp as Date, to: date)
                                let diff = components.hour!
                                let updatedTime = (" \u{2022} \(diff)h")
                                let authorName = ("u/\(author) \u{2022} \(diff)h")
                                let post = Post(authorName: authorName, postTitle: title, postTime: updatedTime, subreddit_name_prefixed: subreddit_name_prefixed, commentsCount: commentsCount, ups: ups, link: link, image: thumbnail )
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
        if URL(string: post.image)?.host != nil{
            cell.imagEView?.isHidden = false
        }else{
            print("true")
            cell.imagEView?.isHidden = true
        }
        
        imageLoader.obtainImageWithPath(imagePath: post.image) { (image) in
            // Before assigning the image, check whether the current cell is visible
            
                
                if let updateCell = tableView.cellForRow(at: indexPath) as? TableCell {

                    updateCell.imagEView.image = image
                }
//                cell.imagEView?.isHidden = false
//                print("false")
//                cell.imagEView.image = image
            
        }
//        if post.image.size.width != 0{
//            cell.imagEView?.isHidden = false
//            cell.imagEView?.image = post.image
//        } else {
//            cell.imagEView?.isHidden = true
//        }
        cell.Comment.text = post.commentsCount
        cell.Ups.text = post.ups
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return cell
    }
    @objc func tapped(sender: UIButton){
        let postTitle = String(describing: self.posts[sender.tag].postTitle)
        let link = String(describing: self.posts[sender.tag].link)
        let item = "PostTitle: \(postTitle)\n link: \(link)"
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == posts.count - 1 {
                self.loadDataFromApi()
       
        }
    }
}
