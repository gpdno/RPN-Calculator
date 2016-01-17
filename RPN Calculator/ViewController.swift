//
//  ViewController.swift
//  RPN Calculator
//
//  Created by Gregory DeNinno on 1/15/16.
//  Copyright © 2016 SCDE. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var buttonSound: AVAudioPlayer = AVAudioPlayer()
    
    var stackNumber: String = ""
    var stackArray = [String]()
    var stackArrayReverse = [String]()
    
    enum Operation: String {
        case Divide = "/"
        case Mutiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Enter = "enter"
        case Empty = "Emply"
    }
    
    var currentOperation: Operation = Operation.Empty
    
    @IBOutlet var workingView: UILabel!
    
    @IBOutlet var collectionOfViews: Array<UILabel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let audioPath = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")!
        
        do {
            
            try buttonSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            
            buttonSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberButton(btn: UIButton) {
        
        playSound()
        
        stackNumber += "\(btn.tag)"
        
        workingView.text = stackNumber

    }
    
    @IBAction func decimalButton(sender: UIButton) {
        
        playSound()
        
        if stackNumber.characters.contains(".") {
            //do nothing

        } else {
            
            if stackNumber == "" {
                
                stackNumber += "0."
                workingView.text = stackNumber
                
            } else {
                
                stackNumber += "."
                workingView.text = stackNumber
            }

        }
    }
    
    @IBAction func clearAllButton(sender: UIButton) {
        
        if stackArray.count != 0 {
            
            _ = stackArray
        
            var i = 0
            
            for _ in stackArray {
                
                if i < 3 {
                    
                    collectionOfViews?[i].text = ""
                    
                    i++
                    
                }
                
            }
            
        }
        stackArray = []
    }
    
    @IBAction func swapButton(sender: UIButton) {
        
        playSound()

        if stackArray.count > 0 {
            
            let temp = stackArray[0]
            stackArray[0] = stackNumber
            stackNumber = temp
            workingView.text = stackNumber
            
        } else {
            workingView.text = "STACK ERROR"
            stackNumber = ""
        }

        displayStack()
    }
    
    @IBAction func plusMinisButton(sender: AnyObject) {
        
        if stackNumber.characters.contains("-") {
            
            stackNumber = stackNumber.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "-"))
            
            workingView.text = stackNumber

        } else {
            
            if stackNumber != "" {
                
                stackNumber = "-" + stackNumber
                
                workingView.text = stackNumber
            }

        }
        
        displayStack()
    }
    
    @IBAction func enterButton(sender: UIButton) {
        
        playSound()
        
        if stackNumber != "" {
            
            stackArray.append(stackNumber)
            
        } else {
            
            stackNumber = "0"
            stackArray.append(stackNumber)
            
        }
        
        stackNumber = ""
        
        workingView.text = "_"
        
        displayStack()

    }
    
    
    @IBAction func plusButton(sender: UIButton) {
        
        performOperation(Operation.Add)
        
    }
    
    @IBAction func minusButton(sender: UIButton) {
        
        performOperation(Operation.Subtract)
    }
    
    @IBAction func multiplyButton(sender: UIButton) {
        
        performOperation(Operation.Mutiply)
    }
    
    @IBAction func divideButton(sender: UIButton) {
        
        performOperation(Operation.Divide)
    }
    
    func performOperation(op: Operation) {
        
        playSound()
        
        switch op {
        case Operation.Add:
            stackNumber = "\(Double(stackArray[0])! + Double(stackNumber)!)"
            
        case Operation.Subtract:
            stackNumber = "\(Double(stackArray[0])! - Double(stackNumber)!)"
            
        case Operation.Mutiply:
            stackNumber = "\(Double(stackArray[0])! * Double(stackNumber)!)"
            
        case Operation.Divide:
            stackNumber = "\(Double(stackArray[0])! / Double(stackNumber)!)"
            
        default:
            print("error")
        }
        
        stackArray.removeLast()
        stackArray.append(stackNumber)
        
        print(stackArray)
        
        stackNumber = ""
        workingView.text = "_"
        displayStack()
    }
    
    func displayStack() {
        
        if stackArray.count != 0 {
            
            stackArrayReverse = stackArray.reverse()
            
            var i = 0
            
            for _ in stackArrayReverse {
                
                if i < 3 {
                    
                    collectionOfViews?[i].text = stackArrayReverse[i]
                    
                    i++

                }

            }

        }

    }
    
    func playSound() {
        
        if buttonSound.playing {
            buttonSound.stop()
        } else {
            buttonSound.play()
        }
    }

}

