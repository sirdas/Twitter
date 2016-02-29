//
//  StatusViewController.swift
//  Twitter
//
//  Created by Reis Sirdas on 2/29/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    var params: [String: String]! = ["status": "", "in_reply_to_status_id": ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.text.text = params["status"]! + " "
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(sender: AnyObject) {
        params["status"] = text.text
        TwitterClient.sharedInstance.tweet(params)
        self.dismissViewControllerAnimated(true, completion: {})
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
