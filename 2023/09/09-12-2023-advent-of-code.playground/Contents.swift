import Foundation

//MARK: Problems 1 & 2
func problem1() -> Int {
    let sequences = ReadFile().read(file: "problem_01").compactMap({$0.split(separator: " ")})
    var results: Int = 0
    for sequence in sequences {
        var foundCero = false
        let values = sequence.compactMap({Int($0)})
        var levels:[[Int]] = []
        
        var newValues = values
        while !foundCero {
            var last = 0
            if newValues.count > 1 {
              last = newValues[newValues.count - 1]
            }
            var prev = 0
            if newValues.count > 2 {
                prev = newValues[newValues.count - 2]
            }
            var prePrev = 0
            if newValues.count > 3 {
                prePrev = newValues[newValues.count - 3]
            }
            
            levels.append([prePrev, prev, last])

            foundCero = last == 0 && prev == 0 && prePrev == 0
            
            for (index, value) in newValues.enumerated() {
                if index == newValues.count - 1 {
                    break
                }
                newValues[index] = newValues[index+1] - value
            }
            
            newValues.remove(at: newValues.count-1)
        }
        
        var result = 0
        for level in levels.reversed() {
            if level.allSatisfy({$0 == 0}) {
                continue
            }
            result += level.last ?? 0
        }
        results += result
    }
    
    return results
}


func problem2() -> Int {
    let sequences = ReadFile().read(file: "problem_01").compactMap({$0.split(separator: " ")})
    var results: Int = 0
    for sequence in sequences {
        var foundCero = false
        let values = sequence.compactMap({Int($0)})
        var levels:[[Int]] = []
        
        var newValues = values
        while !foundCero {
            var first = 0
            if newValues.count > 0 {
                first = newValues[0]
            }
            var next = 0
            if newValues.count > 1 {
                next = newValues[1]
            }
            var nextNext = 0
            if newValues.count > 2 {
                nextNext = newValues[2]
            }
            
            levels.append([first, next, nextNext])

            foundCero = first == 0 && next == 0 && nextNext == 0
            
            for (index, value) in newValues.enumerated() {
                if index == newValues.count - 1 {
                    break
                }
                newValues[index] = newValues[index+1] - value
            }
            
            newValues.remove(at: newValues.count-1)
        }
        
        var result = 0
        for level in levels.reversed() {
            if level.allSatisfy({$0 == 0}) {
                continue
            }
            result -= level.first ?? 0
            result *= -1
        }
        results += result
    }
    
    return results
}

let first = problem1()
let second = problem2()
