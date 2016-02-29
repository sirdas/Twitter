//
//  TweetCell.swift
//  Twitter
//
//  Created by Reis Sirdas on 2/21/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!

    
    var tweet : Tweet!{
        didSet{
            nameLabel.text = tweet.user!.name
            idLabel.text = "@\(tweet.user!.screenname!)"
            tweetLabel.text = tweet.text
            profileButton.setImageForState(UIControlState.Normal , withURL: NSURL(string: tweet.user!.profileImageUrl!)!)
            profileButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
            profileButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
            //thumbImageView!.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            let date = NSCalendar.currentCalendar().components([.Month, .Day], fromDate: tweet.createdAt!)
            timeLabel.text = "\(date.month)/\(date.day)"
            retweetLabel.text = String(tweet.retweetCount)
            likeLabel.text = String(tweet.likeCount)
            likeButton.imageView!.image = UIImage(named: "likeIcon")
            retweetButton.imageView!.image = UIImage(named: "retweetIcon")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileButton.imageView!.layer.cornerRadius = 3
        profileButton.imageView!.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        // Configure the view for the selected state
    }
    
    @IBAction func retweet(sender: AnyObject) {
        if (tweet.isRetweeted == false) {
            TwitterClient.sharedInstance.retweet(String(tweet.id!))
            retweetLabel.text = String(tweet.retweetCount + 1)
        }
    }


    @IBAction func like(sender: AnyObject) {
        if (tweet.isLiked == false) {
            TwitterClient.sharedInstance.like(tweet.id!)
            likeLabel.text = String(tweet.likeCount + 1)
        }
    }
}
