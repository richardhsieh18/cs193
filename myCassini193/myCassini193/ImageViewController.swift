//
//  ImageViewController.swift
//  myCassini193
//
//  Created by chang on 2017/8/8.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController
{
    var imageURL : URL?{
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage()
    {
        if let url = imageURL
        {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents{
                image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageURL = DemoURL.stanford
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
        
    }
    
    fileprivate var imageView = UIImageView()
    
    private var image: UIImage?
    {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

}

extension ImageViewController : UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
