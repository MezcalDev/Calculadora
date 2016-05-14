//
//  CalculatorModel.swift
//  Calculadora
//
//  Created by Emanuel Peña Aguilar on 5/13/16.
//  Copyright © 2016 Mezcal Development. All rights reserved.
//

import UIKit

class CalculatorModel: NSObject {
    static let CalculatorModelOperateNotification = "CalculatorModelOperateNotification"
    enum Operator : String {
        case Sum = "+"
        case Substraction = "-"
        case Multiplication = "*"
        case Division = "/"
    }
    
    private var operandStack = [Double]()
    func pushOperand(operand :Double) {
        operandStack.append(operand)
        
        if operandStack.count == 2 && currentOperator != nil {
            operate()
        }
    }
    
    var lastResult : Double? {
        get {
            if operandStack.count == 1 {
                return operandStack.last
            }
            return nil
        }
    }
    
    private var _currentOperator : Operator?
    var currentOperator : Operator? {
        get {
            return _currentOperator
        }
        set {
            if operandStack.count == 2 && currentOperator != nil {
                operate()
            }
            _currentOperator = newValue
        }
    }
    
    func operate() {
        if operandStack.count == 2 && currentOperator != nil {
            if let currentOperator = currentOperator {
                let rightHand = operandStack.removeLast()
                let leftHand = operandStack.removeLast()
                var result : Double = 0.0
                switch currentOperator {
                case .Sum:
                    result = leftHand + rightHand
                case .Division:
                    result = leftHand / rightHand
                case .Multiplication:
                    result = leftHand * rightHand
                case .Substraction:
                    result = leftHand - rightHand
                }
                
                pushOperand(result)
                self.currentOperator = nil
                NSNotificationCenter.defaultCenter().postNotificationName(CalculatorModel.CalculatorModelOperateNotification, object: self)
            }
        }
    }
}
