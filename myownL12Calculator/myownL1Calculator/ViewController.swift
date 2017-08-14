//
//  ViewController.swift
//  myownL1Calculator
//
//  Created by chang on 2017/7/17.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsTheMiddleOfTyping = false
    
    //L12新增
    private func showSizeClasses(){
        if !userIsTheMiddleOfTyping {
            display.textAlignment = .center
            display.text = "寬 " + traitCollection.horizontalSizeClass.description + " 高 " + traitCollection.verticalSizeClass.description
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showSizeClasses()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (coordinator) in
            self.showSizeClasses()
        }, completion: nil)
    }//L12新增
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.addUnaryOperation(named: "✅"){[weak weakSelf = self] in
            weakSelf?.display.textColor = UIColor.green
            return sqrt($0)
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
            userIsTheMiddleOfTyping = true
        }
        
    }
    
    //Computed Property
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
        
    }
    //Model
    private var brain: CalculatorBrain = CalculatorBrain()
    //為什麼在這呼叫不到brain這個變數

    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTheMiddleOfTyping{
                brain.setOperand(displayValue)
                userIsTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
                brain.performOperation(mathematicalSymbol)
            }
        if let result = brain.result
        {
            displayValue = result
        }
    }
}

extension UIUserInterfaceSizeClass : CustomStringConvertible {
    public var description: String {
        switch self {
        case .compact:
            return "Compact"
        case .regular:
            return "Regular"
        case .unspecified:
            return "??"
        }
    }
}

