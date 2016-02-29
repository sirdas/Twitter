//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Reis Sirdas on 2/16/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets,error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if businesses != nil {
        //            return businesses!.count
        //        } else {
        //            return 0
        //        }
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
                cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.tweet = tweet
        } else if tweetButton.touchInside {
//            let user = User.currentUser
            let statusViewController = segue.destinationViewController as! StatusViewController
//            statusViewController.user = user
        } else if let button = sender as? UIButton {
            let view = button.superview!
            let cell = view.superview as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let user = tweets![indexPath!.row].user
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.user = user
        }
    }
}
