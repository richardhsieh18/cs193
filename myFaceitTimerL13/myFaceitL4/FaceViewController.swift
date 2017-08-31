//
//  ViewController.swift
//  myFaceitL4
//
//  Created by chang on 2017/8/5.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class FaceViewController: VCLLoggingViewController {
    //L5
    @IBOutlet weak var faceView: FaceView!
    {
        didSet
        {
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
//            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
//            tapRecognizer.numberOfTapsRequired = 1
//            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            updateUI()
        }
    }
    //L13
    private struct HeadShake {
        static let angle =  CGFloat.pi/6   //Radians
        static let segmentDuration: TimeInterval = 0.5  //each shake has 3 segment
    }
    
    private func rotateFace(by angle: CGFloat){
        faceView.transform = faceView.transform.rotated(by: angle)
    }
    
    private func shakeHead() {
        UIView.animate(
            withDuration: HeadShake.segmentDuration,
            animations: { self.rotateFace(by: HeadShake.angle) } ,
            completion: { finished in
                if finished {
                    UIView.animate(
                        withDuration: HeadShake.segmentDuration,
                        animations: { self.rotateFace(by: -HeadShake.angle * 2 ) },
                        completion: { finished in
                            UIView.animate(
                                withDuration: HeadShake.segmentDuration,
                                animations: { self.rotateFace(by: HeadShake.angle ) }
                            )
                        }
                    )
                }
            }
        )
    }
    
    
    
    //L5
    func increaseHappiness()
    {
            expression = expression.happier
    }
    func decreaseHappiness()
    {
        expression = expression.sadder
    }
    
    //gesture建議寫在code裡  //L13 56min
    @IBAction func shakeHead(_ sender: UITapGestureRecognizer) {
        shakeHead()
    }
    
    //L5
    func toggleEyes(byReactingTo tapRecgnizer: UITapGestureRecognizer)
    {
        if tapRecgnizer.state == .ended
        {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    

    var expression = FacialExpression(eyes: .closed, mouth: .frown)
    {
        didSet
        {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        switch expression.eyes
        {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5,.frown: -1.0, .smile: 1.0, .neutral: 0.0, .smirk: -0.5]


}

