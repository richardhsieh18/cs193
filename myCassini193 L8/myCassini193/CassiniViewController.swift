//
//  CassiniViewController.swift
//  myCassini193
//
//  Created by chang on 2017/8/10.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController,UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""]
        {
            if let imageVC = (segue.destination.contents as? ImageViewController){
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle 
            }
        }
    }
    //設定進入點為masterViewcontroller
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? ImageViewController, ivc.imageURL == nil  {
                return true
            }
        }
        return false
    }
}

extension UIViewController
{
    var contents: UIViewController {
        if let navcon = self as? UINavigationController
        {
            return navcon.visibleViewController ?? self
        }else{
            return self
        }
    }
}
