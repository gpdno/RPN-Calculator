//
//  Operations.swift
//  RPN Calculator
//
//  Created by Gregory DeNinno on 2/8/16.
//  Copyright © 2016 SCDE. All rights reserved.
//

import Foundation

class Operations {
    
    var numA = Double()
    var numB = Double()
    
    init(numberA: String) {
        self.numA = Double(numberA)!
    }
    
    init(numberA: String, numberB: String) {
        self.numA = Double(numberA)!
        self.numB = Double(numberB)!
    }
    
    var changeSign: Double {
        return -numA
    }
    
    var add:Double {
        return numA + numB
    }
    
    var subtract:Double {
        return numA - numB
    }
    
    var mutiply:Double {
        return numA * numB
    }
    
    var divide:Double {
        return numA / numB
    }
    
    var squr: Double {
        return numA * numA
    }
}