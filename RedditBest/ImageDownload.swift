//
//  ImageDownload.swift
//  RedditBest
//
//  Created by Bhavik Soni on 29/06/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//
import Alamofire
import Foundation
class ImageDownload{
    var cache: NSCache<NSString, UIImage>! = NSCache()
    typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
        print("1")
        if let image = self.cache.object(forKey: imagePath as NSString) {
            print("2")
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            print("3")
            let placeholder = UIImage(named: "images1")!
            DispatchQueue.main.async {
                completionHandler(placeholder)
                print("4")
            }
            print("5")
            Alamofire.request(imagePath).responseData { (response) in
                if let data = response.result.value{
                    do{
                        print("he")
                        if let img: UIImage = UIImage(data: data){
                            self.cache.setObject(img , forKey: imagePath as NSString)
                            DispatchQueue.main.async {
                                completionHandler(img )
                            }
                        }
                        
                    }
                }
                }.resume()
        }
    }
}
