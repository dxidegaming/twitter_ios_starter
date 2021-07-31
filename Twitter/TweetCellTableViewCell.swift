//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Edison Enerio on 7/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    var favorited: Bool = false
    var tweetId: Int = -1
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { Error in
                print("Favorite did not succeed: \(Error)")
            })
        }else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { Error in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { Error in
            print("Error is retweeting: \(Error)")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named:"retweetGreen"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named:"silverRetweet"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named:"2475794-middle"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named:"silver"), for: UIControl.State.normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
