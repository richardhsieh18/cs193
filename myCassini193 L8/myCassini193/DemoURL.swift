//
//  DemoURL.swift
//  myCassini193
//
//  Created by chang on 2017/8/8.
//  Copyright © 2017年 chang. All rights reserved.
//

import Foundation

struct DemoURL {
    static let stanford = URL(string: "https://www-media.stanford.edu/wp-content/uploads/2017/03/24182714/about_landing-1.jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss052e023801_0.jpg",
            "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key,value) in NASAURLStrings{
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
