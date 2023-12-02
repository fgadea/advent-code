import UIKit


//MARK: First Part

func exerciseOne() -> Int {
    let values = ReadFile().read(file: "problem_01")
    
    var calibrationValues: [Int] = []
    let charsToFound = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    for rawValue in values {
        var valueToSave = 0
        var value = rawValue.replacingOccurrences(of: "\n", with: "")
        value = value.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if !value.isEmpty {
            
            let firstValue = value.first(where: { char in
                charsToFound.contains(where: {
                    $0 == String(char)
                })
            })
            
            let lastValue = value.last(where: { char in
                charsToFound.contains(where: {
                    $0 == String(char)
                })
            })
            
            valueToSave = Int("\(String(firstValue ?? "0"))\(String(lastValue ?? "0"))") ?? 0
            
            calibrationValues.append(valueToSave)
        }
    }

    let sum = calibrationValues.reduce(0, +)
    return sum;
}

//MARK: Second Part
func getNumber(_ value: String, reversed: Bool = false) -> String {
    
    var textLine = value
    if reversed {
        textLine = ""
        for char in value {
            textLine = "\(char)\(textLine)"
        }
    }
    
    let numberWordsToDigits: [String: String] = [
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
    ]
    
    var auxString: String = ""
    
    for char in textLine {
        if let number = Int(String(char)) {
            return "\(number)"
        }
        
        if reversed {
            auxString = "\(String(char))\(auxString)"
        } else {
            auxString += String(char)
        }
        for key in numberWordsToDigits.keys {
            if auxString.contains(key) {
                print("aux \(auxString)")
                print("key \(key)")
                let value = numberWordsToDigits[key] ?? ""
                return value
            }
        }
    }
    
    return ""
}
func getValueWithDigits(_ string: String) -> String {
    
    var finalString: String = ""
    
    finalString += getNumber(string)
    
    finalString += getNumber(string, reversed: true)
    
    return finalString
}

func exerciseTwo() -> Int {
    let values = ReadFile().read(file: "problem_02")
    
    var calibrationValues: [Int] = []
    let charsToFound = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    for rawValue in values {
        var valueToSave = 0
        var value = rawValue.replacingOccurrences(of: "\n", with: "")
        
        value = getValueWithDigits(value)
        
        if let num = Int(value) {
            calibrationValues.append(num)
        }
    }

    let sum = calibrationValues.reduce(0, +)
    
    return sum;
}

let value = exerciseOne()
let value = exerciseTwo()

