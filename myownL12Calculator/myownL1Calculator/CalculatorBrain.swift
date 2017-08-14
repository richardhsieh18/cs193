//
//  CalculatorBrain.swift
//  myownL1Calculator
//
//  Created by chang on 2017/7/17.
//  Copyright © 2017年 changname. All rights reserved.
//

import Foundation

//changeSign
//func changeSign(operand: Double) -> Double {
//    return -operand
//}


//!!原本寫好後發現怎麼點binaryoperation都進不去action，後來發現是複製按鈕的時候複製到數字按鈕，
//所以觸發到數字鍵的action，難怪看code看了n次沒有錯結果還是有問題，最後發現是IBAction有問題

struct CalculatorBrain {
    
    mutating func addUnaryOperation(named symbol: String, _ operation: @escaping (Double) -> Double)
    {
        operations[symbol] = Operation.unaryOperation(operation)
    }
    
    private var accumulator: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    //operations為字典
    private var operations: Dictionary<String,Operation> =
        [
    "π": Operation.constant(Double.pi),    //Double.pi,
    "e" : Operation.constant(M_E),   // M_E,
    "根": Operation.unaryOperation(sqrt),  //sqrt,
    "cos":  Operation.unaryOperation(cos), //cos
    "±" : Operation.unaryOperation({ -$0 }),
    
    "×" : Operation.binaryOperation({$0 * $1}),
    "+" : Operation.binaryOperation({$0 + $1}),
    "−" : Operation.binaryOperation({$0 - $1}),
    "÷" : Operation.binaryOperation({$0 / $1}),
    "=" : Operation.equals
        ]
    
    //從viewcontroller連過來的第一個method
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil
                {
                accumulator = function(accumulator!)
                }
                
            case .binaryOperation(let function):
                if accumulator != nil
                {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil {
        accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result: Double? {
        get{
            return accumulator
        }
    }
}
