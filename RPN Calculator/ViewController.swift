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
        case Decimal = "."
        case Divide = "/"
        case Mutiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Enter = "enter"
        case Empty = "Emply"
    }
    
    @IBOutlet var collectionOfViews: Array<UILabel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionOfViews![0].text = "Stack One"
        collectionOfViews![1].text = "Stack One"
        collectionOfViews![2].text = "Stack Two"
        collectionOfViews![3].text = "Stack Three"
        
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
        
        collectionOfViews![0].text = stackNumber

        
    }
    
    @IBAction func decimalButton(sender: UIButton) {
        
        playSound()
        
        if stackNumber.characters.contains(".") {
            //do nothing

        } else {
            stackNumber += "."
            collectionOfViews![0].text = stackNumber
        }
    }
    
    @IBAction func enterButton(sender: UIButton) {
        
        playSound()
        
        stackArray.append(stackNumber)
        
        stackNumber = ""
        
        displayStack()

    }
    
    func displayStack() {
        
        if stackArray.count != 0 {
            
            stackArrayReverse = stackArray.reverse()
            
            var i = 0
            
            for _ in stackArrayReverse {
                
                if i < 4 {
                    
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

