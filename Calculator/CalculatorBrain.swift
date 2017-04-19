//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Andriy Krupych on 4/19/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private enum Operation {
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equals
    }
    
    private struct PendingOperation {
        let operation: (Double, Double) -> Double
        let operand1: Double
        
        func perform(with operand2: Double) -> Double {
            return operation(operand1, operand2)
        }
    }
    
    private(set) var result = 0.0
    
    private var pendingOperation: PendingOperation?
    
    private let operations: Dictionary<String, Operation> = [
        "√" : .unary(sqrt),
        "cos" : .unary(cos),
        "±" : .unary({ -$0 }),
        "+" : .binary({ $0 + $1 }),
        "-" : .binary({ $0 - $1 }),
        "*" : .binary({ $0 * $1 }),
        "/" : .binary({ $0 / $1 }),
        "=" : .equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .unary(let f):
                result = f(result)
            case .binary(let f):
                pendingOperation = PendingOperation(operation: f, operand1: result)
                result = 0.0
            case .equals:
                result = pendingOperation?.perform(with: result) ?? result
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        result = operand
    }
    
    mutating func clear() {
        result = 0.0
        pendingOperation = nil
    }
}
