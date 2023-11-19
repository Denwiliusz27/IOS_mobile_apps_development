//
//  ViewController.swift
//  zad01-calculator
//
//  Created by Daniel_UJ on 18/11/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorStack: UILabel!
    @IBOutlet weak var result: UILabel!
    var calculations: String = ""
    var operators: [Character] = ["+", "-", "x", "/", "(", ")", "."]
    var equalsClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearInput()
    }
    
    func clearInput() {
        calculations = ""
        calculatorStack.text = ""
        result.text = ""
    }
    
    @IBAction func clearInput(_ sender: Any) {
        clearInput()
    }
    
    @IBAction func deleteLastElement(_ sender: Any) {
        calculations = String(calculations.dropLast())
        calculatorStack.text = calculations
    }
    
    func addToCalculatiorStack(element: String){
        if equalsClicked {
            if operators.contains(element) {
                calculations = result.text!
                calculatorStack.text = calculations
                result.text = ""
            } else {
                clearInput()
            }
            equalsClicked = false
        }
        
//        if operators.contains(element) {
//            if equalsClicked {
//                calculations = result.text!
//                calculatorStack.text = calculations
//                result.text = ""
//                equalsClicked = false
//            }
//        }
        
        calculations = calculations + element
        calculatorStack.text = calculations
    }
    
    func canCalculate() -> Bool {
        if calculations != "" && !operators.contains(calculations.last!) {
            return true
        } else {
            return false
        }
    }
    

    @IBAction func add(_ sender: Any) {
        if canCalculate() {
            addToCalculatiorStack(element: "+")
        }
    }
    
    @IBAction func substract(_ sender: Any) {
        if canCalculate() {
            addToCalculatiorStack(element: "-")
        }
    }
    
    @IBAction func multiple(_ sender: Any) {
        if canCalculate() {
            addToCalculatiorStack(element: "*")
        }
    }
    
    @IBAction func divide(_ sender: Any) {
        if canCalculate() {
            addToCalculatiorStack(element: "/")
        }
    }
    
    @IBAction func equals(_ sender: Any) {
        if canCalculate() {
            let tempResult = NSExpression(format:calculations).expressionValue(with: nil, context: nil) as! Double
            
            if floor(tempResult) == tempResult {
                result.text = String(format: "%.0f", tempResult)
            } else {
                result.text = String(format: "%.2f", tempResult)
            }
            
            equalsClicked = true
        }
    }
    
    @IBAction func dot(_ sender: Any) {
        if canCalculate() {
            addToCalculatiorStack(element: ".")
        }
    }
    
    @IBAction func zero(_ sender: Any) {
        addToCalculatiorStack(element: "0")
    }
    
    @IBAction func one(_ sender: Any) {
        addToCalculatiorStack(element: "1")
    }
    
    @IBAction func two(_ sender: Any) {
        addToCalculatiorStack(element: "2")
    }
    
    @IBAction func three(_ sender: Any) {
        addToCalculatiorStack(element: "3")
    }
    
    @IBAction func four(_ sender: Any) {
        addToCalculatiorStack(element: "4")
    }
    
    @IBAction func five(_ sender: Any) {
        addToCalculatiorStack(element: "5")
    }
    
    @IBAction func six(_ sender: Any) {
        addToCalculatiorStack(element: "6")
    }
    
    @IBAction func seven(_ sender: Any) {
        addToCalculatiorStack(element: "7")
    }
    
    @IBAction func eight(_ sender: Any) {
        addToCalculatiorStack(element: "8")
    }
    
    @IBAction func nine(_ sender: Any) {
        addToCalculatiorStack(element: "9")
    }
}
