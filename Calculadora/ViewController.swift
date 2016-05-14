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
    let model = CalculatorModel()
    
    var isTypingNumber = true
    
    @IBOutlet weak var displayTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateFromNotification), name: CalculatorModel.CalculatorModelOperateNotification, object: model)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func updateFromNotification(notification : NSNotification) {
        displayTextField.text = "\(model.lastResult ?? 0)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberAction(sender: UIButton) {
        let number = (sender.titleLabel?.text)!
        displayTextField.text = (isTypingNumber ? displayTextField.text! : "")  + "\(number)"
        isTypingNumber = true
    }
    
    @IBAction func operatorAction(sender: UIButton) {
        let selectedOperator = CalculatorModel.Operator(rawValue: (sender.titleLabel?.text)!)
        
        if isTypingNumber {
            let number = Double(displayTextField.text!)!
            model.pushOperand(number)
            isTypingNumber = false
        }
        model.currentOperator = selectedOperator
    }

    @IBAction func resultAction(sender: UIButton) {
        let number = Double(displayTextField.text!)!
        model.pushOperand(number)
        model.operate()
    }
    
}

