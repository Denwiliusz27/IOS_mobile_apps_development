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
    
    func addToCalculatiorStack(number: String){
        calculations = calculations + number
        calculatorStack.text = calculations
    }
    
    
    
    @IBAction func add(_ sender: Any) {
        addToCalculatiorStack(number: "+")
    }
    
    
    @IBAction func equals(_ sender: Any) {
        var tempResult = NSExpression(format: calculations).expressionValue(with: nil, context: nil) as! Double
        result = tempResult
    }
    
    
    @IBAction func zero(_ sender: Any) {
        addToCalculatiorStack(number: "0")
    }
    
    @IBAction func one(_ sender: Any) {
        addToCalculatiorStack(number: "1")
    }
    
    
    @IBAction func two(_ sender: Any) {
        addToCalculatiorStack(number: "2")
    }
    
    @IBAction func three(_ sender: Any) {
        addToCalculatiorStack(number: "3")
    }
    
    @IBAction func four(_ sender: Any) {
        addToCalculatiorStack(number: "4")
    }
    
    @IBAction func five(_ sender: Any) {
        addToCalculatiorStack(number: "5")
    }
    
    @IBAction func six(_ sender: Any) {
        addToCalculatiorStack(number: "6")
    }
    
    @IBAction func seven(_ sender: Any) {
        addToCalculatiorStack(number: "7")
    }
    
    @IBAction func eight(_ sender: Any) {
        addToCalculatiorStack(number: "8")
    }
    
    @IBAction func nine(_ sender: Any) {
        addToCalculatiorStack(number: "9")
    }
    
    
}
