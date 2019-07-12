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
enum searchScope : Int{
    case name = 0
    case title = 1
    case subreddit = 2
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
    }
}
class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   var sortByName = ""
    var interval = ""
    var flagOfInterval = false
   var flag = true
        let myIndicator = UIActivityIndicatorView(style : UIActivityIndicatorView.Style.medium)
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var styleButton: UIButton!
    @IBOutlet weak var sortByButton: UIButton!
    @IBAction func sortBy(_ sender: Any) {
    
            myIndicator.startAnimating()
            let alert = UIAlertController(title: "SORT POSTS BY", message: "Please Select an Option", preferredStyle: .actionSheet)
            let hotButton = UIAlertAction(title: "Hot", style: .default, handler: { (_) in
                self.name = ""
                self.sortByName = "HOT".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
        alert.addAction(hotButton)
            let newButton = UIAlertAction(title: "New", style: .default, handler: { (_) in
                self.name = ""
                self.sortByName = "NEW".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
        alert.addAction(newButton)
       

            let topButton = UIAlertAction(title: "Top", style: .default, handler: { (_) in
                
                    let alert = UIAlertController(title: "TOP POSTS FROM", message: "Please Select an Option", preferredStyle: .actionSheet)
                    self.flagOfInterval = true
                    self.name = ""
                    let nowButton = UIAlertAction(title: "Now", style: .default, handler: { (_) in
                        
                        self.interval = "hour"
                        self.sortByName = "TOP".lowercased()
                        self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS NOW", for: .normal)
                        self.getAccessToken(type: self.sortByName)
                    })
                    
                    let todayButton = UIAlertAction(title: "Today", style: .default, handler: { (_) in
                        self.interval = "day"
                        self.sortByName = "TOP".lowercased()
                        self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS TODAY", for: .normal)
                        self.getAccessToken(type: self.sortByName)
                    })
                    
                    let weekButton = UIAlertAction(title: "This Week", style: .default, handler: { (_) in
                        self.interval = "week"
                        self.sortByName = "TOP".lowercased()
                        self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS THIS WEEK", for: .normal)
                        self.getAccessToken(type: self.sortByName)
                    })
                    
                    let monthButton = UIAlertAction(title: "This Month", style: .default, handler: { (_) in
                        self.interval = "month"
                        self.sortByName = "TOP".lowercased()
                        self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS THIS MONTH", for: .normal)
                        self.getAccessToken(type: self.sortByName)
                    })
                    let yearButton = UIAlertAction(title: "This Year", style: .default, handler: { (_) in
                        self.interval = "year"
                        self.sortByName = "TOP".lowercased()
                        self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS THIS YEAR", for: .normal)
                        self.getAccessToken(type: self.sortByName)
                    })
                    let allButton = UIAlertAction(title: "All Time", style: .default, handler: { (_) in
                        self.interval = "all"
                        self.sortByName = "TOP".lowercased()
                        self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS ALL TIME", for: .normal)
                        self.getAccessToken(type: self.sortByName)
                    })
                    alert.addAction(nowButton)
                    alert.addAction(todayButton)
                    alert.addAction(weekButton)
                    alert.addAction(monthButton)
                    alert.addAction(yearButton)
                    alert.addAction(allButton)
                
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (_) in
                    self.getAccessToken(type: "hot")
                    self.dismiss(animated: true, completion: nil)
                }))

                    self.present(alert, animated: true, completion: {
                        print("completion block")
                    })
               
                
            })
            alert.addAction(topButton)
            
        let controversialButton = UIAlertAction(title: "Controversial", style: .default, handler: { (_) in
            let alert = UIAlertController(title: "CONTROVERSIAL POSTS FROM", message: "Please Select an Option", preferredStyle: .actionSheet)
            self.flagOfInterval = true
            self.name = ""

            let nowButton = UIAlertAction(title: "Now", style: .default, handler: { (_) in
                
                self.interval = "hour"
                self.sortByName = "CONTROVERSIAL".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS NOW", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
            
            let todayButton = UIAlertAction(title: "Today", style: .default, handler: { (_) in
                self.interval = "day"
                self.sortByName = "CONTROVERSIAL".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS TODAY", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
            
            let weekButton = UIAlertAction(title: "This Week", style: .default, handler: { (_) in
                self.interval = "week"
                self.sortByName = "CONTROVERSIAL".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS THIS WEEK", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
            
            let monthButton = UIAlertAction(title: "This Month", style: .default, handler: { (_) in
                self.interval = "month"
                self.sortByName = "CONTROVERSIAL".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS THIS MONTH", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
            let yearButton = UIAlertAction(title: "This Year", style: .default, handler: { (_) in
                self.interval = "year"
                self.sortByName = "CONTROVERSIAL".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS THIS YEAR", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
            let allButton = UIAlertAction(title: "All Time", style: .default, handler: { (_) in
                self.interval = "all"
                self.sortByName = "CONTROVERSIAL".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS ALL TIME", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
            alert.addAction(nowButton)
            alert.addAction(todayButton)
            alert.addAction(weekButton)
            alert.addAction(monthButton)
            alert.addAction(yearButton)
            alert.addAction(allButton)
            
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (_) in
                self.getAccessToken(type: "hot")
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
            
        })
        alert.addAction(controversialButton)
            let risingButton = UIAlertAction(title: "Rising", style: .default, handler: { (_) in
                self.name = ""

                self.sortByName = "RISING".lowercased()
                self.sortByButton.setTitle("\(self.sortByName.uppercased()) POSTS", for: .normal)
                self.getAccessToken(type: self.sortByName)
            })
        alert.addAction(risingButton)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (_) in
                self.getAccessToken(type: "hot")
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
            posts.removeAll()
            OperationQueue.main.addOperation ({
                self.tableView.reloadData()
            })
//            let sortByButtonName = "\(self.sortType)".uppercased()
//            sortByButton.setTitle(sortByButtonName, for: .normal)
//            getAccessToken(type: sortType)
        
       
    }
    @IBAction func changePostStyle(_ sender: Any) {
        let alert = UIAlertController(title: "Post Style", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Card", style: .default, handler: { (_) in
            self.styleButton.setTitle("CARD", for: .normal)
            self.flag = true
            OperationQueue.main.addOperation ({
                self.tableView.reloadData()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Classic", style: .default, handler: { (_) in
            self.styleButton.setTitle("CLASSIC", for: .normal)
            self.flag = false
            OperationQueue.main.addOperation ({
                self.tableView.reloadData()
            })
        }))
        
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        myIndicator.center = view.center
        searchBar.autocapitalizationType = .none
        view.addSubview(myIndicator)
        self.navigationItem.setHidesBackButton(true, animated: false)
        getAccessToken(type: "hot")
        searchBar.showsScopeBar = false
    }
//    func sendIntervalToPostViewController(myData: String){
//        interval = myData
//        flagOfInterval = true
//    }
//    func sendDataToPostViewController(myData: String) {
//        posts.removeAll()
//        OperationQueue.main.addOperation ({
//            self.tableView.reloadData()
//        })
//        self.sortType = myData
//        name = ""
//        let sortByButtonName = "\(self.sortType)".uppercased()
//        sortByButton.setTitle(sortByButtonName, for: .normal)
//        getAccessToken(type: sortType)
//    }
    
//    @IBAction func selectStyle(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            flag = true
//            OperationQueue.main.addOperation ({
//                self.tableView.reloadData()
//            })
//        case 1:
//            flag = false
//            OperationQueue.main.addOperation ({
//                self.tableView.reloadData()
//            })
//        default:
//            break
//        }
//    }
    @IBOutlet weak var searchBar: UISearchBar!
    var accessToken: Any = ""
    var posts = [Post]()
    var searchedPost = [Post]()
    var name: String = ""
    var searchIsActive = false
    let imageLoader = ImageDownload()
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "getDataSegue" {
//            let secondVC: SortByViewController = segue.destination as! SortByViewController
//            secondVC.delegate = self
//        }
//    }
    
    func getAccessToken(type: String){
        myIndicator.startAnimating()
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
                        print(self.interval)
                        self.loadDataFromApi(text: type)
                    }
                case .failure(let error):
                    print(error)

           }
        }
     }

    func loadDataFromApi(text: String){
        let token = "bearer \(self.accessToken)"
        let headers = ["Content-Type" : "application/x-www-form-urlencoded", "Authorization" : "\(token)"]
       
        guard let api_url = URL(string: "https://oauth.reddit.com/\(text)") else { return }
        var parameter = Parameters()
        if flagOfInterval{
            parameter = ["show": "", "t": "\(interval)", "after": "\(name)", "limit": 10]
            print(parameter)
        }
        else{
            parameter = ["show": "","after": "\(name)", "limit": 10]
            print(parameter)
        }
        
        Alamofire.request(api_url, method: .get ,parameters: parameter, headers: headers).validate().responseJSON { (response) in
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
                                self.myIndicator.stopAnimating()
                                print(title)

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

        if searchIsActive{
            return searchedPost.count
        }else{
            return posts.count
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: (flag ? "Cell1" : "Cell2"), for: indexPath) as! TableCell
        
        let post : Post
        if searchIsActive{
            post = searchedPost[indexPath.row]
        }else{
                searchBar.showsScopeBar = false
                post = posts[indexPath.row]
        }
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
                if let updateCell = tableView.cellForRow(at: indexPath) as? TableCell {
                    updateCell.imagEView.image = image
                }
            }
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
            self.loadDataFromApi(text: sortByName)
        }
    }
}
extension PostViewController: UISearchBarDelegate{
    func searchBarScope(index: Int) {
        //        searchBar.showsScopeBar = true
        switch index {
        case searchScope.name.rawValue:
            searchBar.placeholder = "Enter Author Name"
            searchedPost = posts.filter({ q -> Bool in
                guard let text = searchBar.text else { return false }
                return q.authorName.lowercased().contains(text.lowercased())
            })

            OperationQueue.main.addOperation ({
                self.tableView.reloadData()
            })

        case searchScope.title.rawValue:
            searchedPost = posts.filter({ q -> Bool in
                searchBar.placeholder = "Enter Title"
                guard let text = searchBar.text else { return false }
                return q.postTitle.lowercased().contains(text.lowercased())

            })

            OperationQueue.main.addOperation ({
                self.tableView.reloadData()
            })
        case searchScope.subreddit.rawValue:
            searchBar.placeholder = "Enter SubReddit"
            searchedPost = posts.filter({ q -> Bool in

                guard let text = searchBar.text else { return false }
                return q.subreddit_name_prefixed.lowercased().contains(text.lowercased())
            })

            OperationQueue.main.addOperation ({
                self.tableView.reloadData()
            })
        default:
            break
        }

    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchBarScope(index: searchBar.selectedScopeButtonIndex)

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {



        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchIsActive = true
        guard !searchText.isEmpty else {
            self.searchedPost = self.posts
            searchBar.endEditing(true)
            OperationQueue.main.addOperation ({
                self.tableView.reloadData()
            })
            return
        }
        searchBar.showsScopeBar = true
        switch searchBar.selectedScopeButtonIndex {
        case 0:
            searchBarScope(index: searchBar.selectedScopeButtonIndex)

        case 1:
            searchBarScope(index: searchBar.selectedScopeButtonIndex)


        case 2:
            searchBarScope(index: searchBar.selectedScopeButtonIndex)

        default:
            break


    }

    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchIsActive = false
        searchBar.text = ""
        searchBar.placeholder = "Enter"
        searchBar.showsScopeBar = false
        searchBar.selectedScopeButtonIndex = 0
        searchBar.endEditing(true)
        self.searchedPost = self.posts
        OperationQueue.main.addOperation ({
            self.tableView.reloadData()
        })
    }
}
