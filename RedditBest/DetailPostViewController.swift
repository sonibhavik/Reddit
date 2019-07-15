//
//  DetailPostViewController.swift
//  RedditBest
//
//  Created by Bhavik Soni on 13/07/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var subredditLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var upVotes: UITextField!
    @IBOutlet weak var commentsCount: UITextField!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var scrollImageView: UIScrollView!
    var Postimage = ""
    var Posttitle = ""
    var subreddit = ""
    var authorName = ""
    var UpVotes = ""
    var comments = ""
    var postLink = ""
    let imageLoader = ImageDownload()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return postImage
    }
    func imageAdd(txtField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollImageView.minimumZoomScale = 1.0
        self.scrollImageView.maximumZoomScale = 6.0
        subredditLabel.text = subreddit
        authorNameLabel.text = authorName
        postTitle.text = Posttitle
        if URL(string: Postimage)?.host != nil{
            self.postImage.isHidden = false
            self.scrollImageView.isHidden = false
        }else{
            self.scrollImageView.isHidden = true
            self.postImage.isHidden = true
        }
        imageLoader.obtainImageWithPath(imagePath: Postimage) { (image) in
            print(self.Postimage)
            
            self.postImage.image = image
        }
        let commentImage = UIImage(named: "comment")
        imageAdd(txtField: commentsCount, andImage: commentImage!)
        let arrowImage = UIImage(named: "arrow")
        imageAdd(txtField: upVotes, andImage: arrowImage!)
        upVotes.text = UpVotes
        commentsCount.text = comments
        shareButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func tapped(sender: UIButton){
        let Title = String(describing: Posttitle)
        let link = String(describing: postLink)
        let item = "PostTitle: \(Title)\n link: \(link)"
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
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