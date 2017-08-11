//
//  TweetTableViewCell.swift
//  mySmashtagL9
//
//  Created by chang on 2017/8/11.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet : Twitter.Tweet? {didSet{ updateUI() }}
    
    private func updateUI(){
        tweetTextLabel.text = tweet?.text
        tweetUserLabel.text = tweet?.user.description
        if let profileImageURL = tweet?.user.profileImageURL {
            if let imageData = try? Data(contentsOf: profileImageURL){
                //在這邊主緒非同步，讓ImageView先顯現出來，很快!!!
                DispatchQueue.main.async {
                    self.tweetProfileImageView.image = UIImage(data: imageData)
                }
            }
            
        }else{
            tweetProfileImageView.image = nil
        }
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            }else{
                formatter.dateStyle = .short
            }
            tweetCreatedLabel.text = formatter.string(from: created)
        }else{
            tweetCreatedLabel.text = nil
        }
    }
    
}
