//
//  ViewController.swift
//  Simple Calculator
//
//  Created by Leala Othman on 4/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var container: UIView!
    
    var firstNum = 0
    var total = 0
    var currentOp: Operation?
    
    enum Operation{
        case add, sub, mult, div
    }
    
    private var result: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Times New Roman", size: 100)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        numberPadUI()
    }
    
    private func numberPadUI(){
        let numpadButton: CGFloat = view.frame.size.width / 4
        
        let zero = UIButton(frame: CGRect(
                        x: 0,
                        y: container.frame.size.height-numpadButton,
                        width: numpadButton*3,
                        height: numpadButton))
        
        zero.setTitle("0", for: .normal)
        zero.setTitleColor(.black, for: .normal)
        zero.backgroundColor = .white
        zero.tag = 1
        zero.addTarget(self, action: #selector(zeroPressed), for: .touchUpInside)
        container.addSubview(zero)
        
        
        let clear = UIButton(frame: CGRect(
                        x: 0,
                        y: container.frame.size.height-(numpadButton*5),
                        width: view.frame.size.width - numpadButton,
                        height: numpadButton))
        
        clear.setTitle("C", for: .normal)
        clear.setTitleColor(.black, for: .normal)
        clear.backgroundColor = .white
        container.addSubview(clear)
        
        for x in 0..<3 {
            let row1 = UIButton(frame: CGRect(
                        x: numpadButton * CGFloat(x),
                        y: container.frame.size.height-(numpadButton*2),
                        width: numpadButton,
                        height: numpadButton))
            
            row1.setTitle("\(x+1)", for: .normal)
            row1.setTitleColor(.black, for: .normal)
            row1.backgroundColor = .white
            row1.tag = x + 2
            row1.addTarget(self, action: #selector(numPressed(_:)), for: .touchUpInside)

            container.addSubview(row1)
        }
        
        for x in 0..<3 {
            let row2 = UIButton(frame: CGRect(
                        x: numpadButton * CGFloat(x),
                        y: container.frame.size.height-(numpadButton*3),
                        width: numpadButton,
                        height: numpadButton))
            
            row2.setTitle("\(x+4)", for: .normal)
            row2.setTitleColor(.black, for: .normal)
            row2.backgroundColor = .white
            row2.tag  = x+5
            row2.addTarget(self, action: #selector(numPressed(_:)), for: .touchUpInside)

            container.addSubview(row2)
        }
        
        for x in 0..<3 {
            let row3 = UIButton(frame: CGRect(
                        x: numpadButton * CGFloat(x),
                        y: container.frame.size.height-(numpadButton*4),
                        width: numpadButton,
                        height: numpadButton))
            
            row3.setTitle("\(x+7)", for: .normal)
            row3.setTitleColor(.black, for: .normal)
            row3.backgroundColor = .white
            row3.tag = x+8
            row3.addTarget(self, action: #selector(numPressed(_:)), for: .touchUpInside)
            container.addSubview(row3)
        }
        
        
        let operations = ["=","+","-","x","÷"]
        
        for x in 0..<5 {
            let opsButton = UIButton(frame: CGRect(
                            x: numpadButton * 3,
                            y: container.frame.size.height-(numpadButton*CGFloat(x+1)),
                            width: numpadButton,
                            height: numpadButton))
            
            opsButton.setTitle(operations[x], for: .normal)
            opsButton.setTitleColor(.white, for: .normal)
            opsButton.backgroundColor = .purple
            
            opsButton.tag = x+1
            container.addSubview(opsButton)
            
            opsButton.addTarget(self, action: #selector(opPressed(_:)), for: .touchUpInside)
        }
        
        
        result.frame = CGRect(
                        x: -10,
                        y: clear.frame.origin.y - 110,
                        width: view.frame.size.width,
                        height: 100)
        container.addSubview(result)
        
        //functionailty of buttons
        
        clear.addTarget(self, action: #selector(pressClear), for: .touchUpInside)
        
    }

    @objc func pressClear() {
        result.text = "0"
        currentOp = nil
        firstNum = 0
    }
    
    @objc func zeroPressed(){
        
        if  result.text != "0" {
            if let text = result.text{
                result.text = "\(text)\(0)"
            }
        }
    }
    
    @objc func numPressed(_ sender: UIButton){
        let  tag = sender.tag - 1
        
        if  result.text == "0" {
            result.text = "\(tag)"
        }
        else if let text = result.text {
            result.text = "\(text)\(tag)"
        }
    }
    
    @objc func opPressed(_ sender: UIButton){
        let  tag = sender.tag
        
        if let  text = result.text, let val = Int(text), firstNum == 0{
            firstNum =  val
            result.text = "0"
        }
        
        if tag == 1{
            if let op = currentOp{
                var secondNum = 0
                if let text = result.text, let val = Int(text){
                    secondNum =  val
                }
                
                switch op {
                
                case .add:
                    let total = firstNum + secondNum
                    result.text = "\(total)"
                    
                    break
                    
                case .sub:
                    let total = firstNum - secondNum
                    result.text = "\(total)"
                    
                    break
                    
                case .mult:
                    let total = firstNum * secondNum
                    result.text = "\(total)"
                    
                    break
                    
                case .div:
                    let total = firstNum / secondNum
                    result.text = "\(total)"
                    
                    break
                }
            }
            
        }
        
        else if tag == 2 {
            currentOp = .add
        }
        else if tag == 3 {
            currentOp = .sub
        }
        else if tag == 4 {
            currentOp  = .mult
        }
        else if tag == 5{
            currentOp = .div
        }
    }

}

