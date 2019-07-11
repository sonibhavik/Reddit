//
//  SortByViewController.swift
//  RedditBest
//
//  Created by Bhavik Soni on 11/07/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//

import UIKit
protocol MyDataSendingDelegateProtocol {
    func sendDataToPostViewController(myData: String)
    func sendIntervalToPostViewController(myData: String)
}
class SortByViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var dataToBeSent = ""
    let intervals = ["Now","Today","This week","This Month","This Year","All Time"]
    var interval = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervals[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervals.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let intervalType = intervals[row]
        if pickerView == topPicker{
            dataToBeSent = "top"
        }else{
            dataToBeSent = "controversial"
        }
        switch intervalType {
        case "Now":
            interval = "hour"
            if self.delegate != nil{
                let dataOfInterval = interval
                self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
                self.delegate?.sendIntervalToPostViewController(myData: dataOfInterval)
            }
            self.dismiss(animated: true, completion: nil)
        case "Today":
            interval = "day"
            if self.delegate != nil{
                let dataOfInterval = interval
                self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
                self.delegate?.sendIntervalToPostViewController(myData: dataOfInterval)
            }
            self.dismiss(animated: true, completion: nil)
        case "This week":
            interval = "week"
            if self.delegate != nil{
                let dataOfInterval = interval
                self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
                self.delegate?.sendIntervalToPostViewController(myData: dataOfInterval)
            }
            self.dismiss(animated: true, completion: nil)
        case "This Month":
            interval = "month"
            if self.delegate != nil{
                let dataOfInterval = interval
                self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
                self.delegate?.sendIntervalToPostViewController(myData: dataOfInterval)
            }
            self.dismiss(animated: true, completion: nil)
        case "This Year":
            interval = "year"
            if self.delegate != nil{
                let dataOfInterval = interval
                self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
                self.delegate?.sendIntervalToPostViewController(myData: dataOfInterval)
            }
            self.dismiss(animated: true, completion: nil)
        case "All Time":
            interval = "all"
            if self.delegate != nil{
                let dataOfInterval = interval
                self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
                self.delegate?.sendIntervalToPostViewController(myData: dataOfInterval)
            }
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var topPicker: UIPickerView!
    @IBOutlet weak var controversialPicker: UIPickerView!
    var delegate: MyDataSendingDelegateProtocol? = nil
    @IBAction func hotButton(_ sender: Any) {
        if self.delegate != nil{
            let dataToBeSent = "hot"
            self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
            dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func newButton(_ sender: Any) {
        if self.delegate != nil{
            let dataToBeSent = "new"
            self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
            dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func topButton(_ sender: Any) {
        topPicker.isHidden = false
        
        
    }
    @IBAction func controversialButton(_ sender: Any) {
        controversialPicker.isHidden = false
       
        
    }
    @IBAction func risingButton(_ sender: Any) {
        if self.delegate != nil{
            let dataToBeSent = "rising"
            self.delegate?.sendDataToPostViewController(myData: dataToBeSent)
            dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
