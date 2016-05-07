//
//  ViewController.swift
//  Calculadora
//
//  Created by Emanuel Peña Aguilar on 5/6/16.
//  443 1685024 (Whatsapp)
//  Skype: leg10n_
//  emanuel@mezcaldev.com
//  Copyright © 2016 Mezcal Development. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    enum Operator : String {
        case Sum = "+"
        case Substraction = "-"
        case Multiplication = "*"
        case Division = "/"
    }

    var currentOperator : Operator?
    
    
    @IBOutlet weak var leftOperandTextField: UITextField!
    
    @IBOutlet weak var rightOperandTextField: UITextField!
    
    @IBOutlet weak var resultTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberAction(sender: UIButton) {
        var number = (sender.titleLabel?.text)!
        if let currentOperator = currentOperator {
            rightOperandTextField.text = rightOperandTextField.text! + "\(number)"
        } else {
            leftOperandTextField.text = leftOperandTextField.text! + "\(number)"
        }
    }
    
    @IBAction func operatorAction(sender: UIButton) {
        let selectedOperator = Operator(rawValue: (sender.titleLabel?.text)!)
        currentOperator = selectedOperator
    }

    @IBAction func resultAction(sender: UIButton) {
        if let currentOperator = currentOperator {
            let leftHand = Double(leftOperandTextField.text!)!
            let rightHand = Double(rightOperandTextField.text!)!
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
            
            resultTextField.text = "\(result)"
        }
    }
    
}

