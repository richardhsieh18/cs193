//
//  EmotionsViewController.swift
//  myFaceitL4
//
//  Created by chang on 2017/8/6.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class EmotionsViewController: VCLLoggingViewController
{
    

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //detailviewcontroller加上navigationController後需作的處理
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController
        {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        
        if let faceViewController = destinationViewController as? FaceViewController,
                let identifier = segue.identifier,
                let expression = emotionalFaces[identifier]
                {
                    faceViewController.expression = expression
                    //幫detailVC加上Title，使用sender的currentTitle
                    faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
                    //faceViewController.navigationItem.title = identifier //這樣也可以阿++自己想的
                }

    }
    
    
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
    ]


}
