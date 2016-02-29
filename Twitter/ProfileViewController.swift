//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Reis Sirdas on 2/28/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var fingLabel: UILabel!
    @IBOutlet weak var fersLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user!.name
        idLabel.text = "@\(user!.screenname!)"
        tweetsLabel.text = String(user!.tweetsCount!)
        fingLabel.text = String(user!.followingCount!)
        fersLabel.text = String(user!.followersCount!)
        bannerImageView.setImageWithURL(NSURL(string: user!.bannerImageUrl!)!)
        thumbImageView.setImageWithURL(NSURL(string: user!.profileImageUrl!)!)
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
