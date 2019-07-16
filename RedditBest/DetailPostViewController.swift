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
    
    @IBOutlet weak var commentsCount: UIButton!
    @IBOutlet weak var upVotes: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var scrollImageView: UIScrollView!
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var Postimage = ""
    var Posttitle = ""
    var subreddit = ""
    var authorName = ""
    var UpVotes = ""
    var comments = ""
    var postLink = ""
    let imageLoader = ImageDownload()
    var show = true
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
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        sender.numberOfTapsRequired = 2
        guard sender.view != nil else {
            return
        }
        if(self.scrollImageView.zoomScale > self.scrollImageView.minimumZoomScale){
            self.scrollImageView.setZoomScale(self.scrollImageView.minimumZoomScale, animated: true)
        }
        else{
            self.scrollImageView.setZoomScale(self.scrollImageView.maximumZoomScale, animated: true)
        }
    }
    @IBAction func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
        gestureRecognizer.numberOfTapsRequired = 1
            guard gestureRecognizer.view != nil else { return }
            if show {
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    self.subredditLabel.alpha = 0
                    self.authorNameLabel.alpha = 0
                    self.postTitle.alpha = 0
                    self.upVotes.alpha = 0
                    self.commentsCount.alpha = 0
                    self.shareButton.alpha = 0
                    // Here you will get the animation you want
                }, completion: { _ in
                    self.subredditLabel.isHidden = true
                    self.authorNameLabel.isHidden = true
                    self.postTitle.isHidden = true
                    self.upVotes.isHidden = true
                    self.commentsCount.isHidden = true
                    self.shareButton.isHidden = true// Here you hide it when animation done
                })
                show = !show
            }else {
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.subredditLabel.alpha = 0.5
                    self.authorNameLabel.alpha = 0.5
                    self.postTitle.alpha = 0.5
                    self.upVotes.alpha = 0.5
                    self.commentsCount.alpha = 0.5
                    self.shareButton.alpha = 0.5
                // Here you will get the animation you want
                }, completion: { _ in
                    self.subredditLabel.isHidden = false
                    self.authorNameLabel.isHidden = false
                    self.postTitle.isHidden = false
                    self.upVotes.isHidden = false
                    self.commentsCount.isHidden = false
                    self.shareButton.isHidden = false// Here you hide it when animation done
                }
                )
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.subredditLabel.alpha = 1
                    self.authorNameLabel.alpha = 1
                    self.postTitle.alpha = 1
                    self.upVotes.alpha = 1
                    self.commentsCount.alpha = 1
                    self.shareButton.alpha = 1
                    // Here you will get the animation you want
                }, completion: { _ in
                    self.subredditLabel.isHidden = false
                    self.authorNameLabel.isHidden = false
                    self.postTitle.isHidden = false
                    self.upVotes.isHidden = false
                    self.commentsCount.isHidden = false
                    self.shareButton.isHidden = false// Here you hide it when animation done
                }
                )
                show = !show
            }
        
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
        let comment = " \(comments)"
        commentsCount.setTitle(comment, for: .normal)
        upVotes.setTitle(UpVotes, for: .normal)
        
        shareButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        
        // function which is triggered when handleTap is called
       
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
