//
//  DetailViewController.swift
//  Twitter
//
//  Created by Reis Sirdas on 2/28/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    var tweet : Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet.user!.name
        idLabel.text = "@\(tweet.user!.screenname!)"
        textLabel.text = tweet.text
        thumbImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        let date = NSCalendar.currentCalendar().components([.Month, .Day, .Year, .Hour, .Minute], fromDate: tweet.createdAt!)
        timeLabel.text = "\(date.month)/\(date.day)/\(date.year), \(date.hour):\(date.minute)"
        retweetLabel.text = String(tweet.retweetCount)
        likeLabel.text = String(tweet.likeCount)
        
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retweetAction(sender: AnyObject) {
        if (tweet.isRetweeted == false) {
            TwitterClient.sharedInstance.retweet(String(tweet.id!))
            retweetLabel.text = String(tweet.retweetCount + 1)
        }
    }

    @IBAction func likeAction(sender: AnyObject) {
        if (tweet.isLiked == false) {
            TwitterClient.sharedInstance.like(tweet.id!)
            likeLabel.text = String(tweet.likeCount + 1)
        }
    }

    @IBAction func replyAction(sender: AnyObject) {
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(rSegue: UIStoryboardSegue, sender: AnyObject?) {
        let params: [String: String] = ["status": idLabel.text!, "in_reply_to_status_id": "@\(tweet.id)"]
        let statusViewController = rSegue.destinationViewController as! StatusViewController
        statusViewController.params = params
//        statusViewController.text.text = idLabel.text! as String
    }


}
