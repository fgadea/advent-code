import Foundation

//MARK: Problems 1 & 2

func leastCommonMultiple(values: [Int]) -> Int {
    var result: Int = 1
    for value in values {
        let gcd = greatestCommonDivisor(value, result)
        result = (value * result)/gcd
    }
    return result
  }

func greatestCommonDivisor(_ x: Int, _ y: Int) -> Int {
    let result: Int = x % y
    if result != 0{
        return greatestCommonDivisor(y, result)
    } else{
        return y
    }
}

func getData() -> (directions: String, paths: [String: (String, String)]) {
    var lines = ReadFile().read(file: "problem_01")
    let directions = lines.removeFirst()
    
    var paths: [String: (String, String)] = [:]
    for line in lines {
        var components = line.split(separator: " = ")
        let key = String(components[0].split(separator: " ")[0])
        _ = components[1].removeFirst()
        _ = components[1].removeLast()
        let tupleComponents = components[1].split(separator: ", ").compactMap({String($0)})
        paths[key] = (tupleComponents[0], tupleComponents[1])
    }
    
    return (directions, paths)
}

func problem1() -> Int {
    let data = getData()
    let directions = data.directions
    let paths = data.paths
    
    var next = "AAA"
    var iterations = 1
    while true {
        for direction in directions {
            guard let values = paths[next] else {
                return 0
            }
            next = direction == "R" ? values.1 : values.0
            if next == "ZZZ" {
                return iterations
            }
            iterations += 1
            
        }
    }
}


func problem2() -> Int {
    let data = getData()
    let directions = data.directions
    let paths = data.paths
    
    var results: [Int:Int] = [:]
    var keys = paths.keys.filter({$0.last == "A"})
    var iterations = 0
    while true {
        for direction in directions {
            let values = keys.compactMap({direction == "R" ? paths[$0]?.1 : paths[$0]?.0})
            
            for (index, value) in values.enumerated() {
                if value.last == "Z" {
                    results[index] = iterations + 1
                    if results.keys.count == values.count {
                        return leastCommonMultiple(values: Array(results.values))
                    }
                }
            }
            
            keys = values
            iterations += 1
            
        }
    }
}

let first = problem1()
let second = problem2()
