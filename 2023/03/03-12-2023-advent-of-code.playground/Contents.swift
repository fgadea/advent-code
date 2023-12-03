import UIKit


struct Position {
    let start: Int
    let end: Int
}
struct EngineElement {
    let id: UUID = UUID()
    let row: Int
    let column: Int
    let data: String
}

func mapElements() ->  (symbols: [EngineElement], numbers: [EngineElement]) {
    let values = ReadFile().read(file: "problem_01")

    var symbols:[EngineElement] = []
    var numbers:[EngineElement] = []

    for (row, value) in values.enumerated() {
        var number: String = ""
        var tempColumn = -1
        for (column, char) in value.enumerated() {
            var str = String(char)
            if char.isNumber {
                if tempColumn == -1 {
                    tempColumn = column
                }
                number += str
                if column == value.count - 1 {
                    let number = EngineElement(row: row, column: tempColumn, data: number)
                    numbers.append(number)
                }
            } else if str != "." {
                if !number.isEmpty {
                    let number = EngineElement(row: row, column: tempColumn, data: number)
                    numbers.append(number)
                }
                number = ""
                tempColumn = -1
                let symbol = EngineElement(row: row, column: column, data: str)
                symbols.append(symbol)
            }
            
            else {
                if !number.isEmpty {
                    let number = EngineElement(row: row, column: tempColumn, data: number)
                    numbers.append(number)
                }
                number = ""
                tempColumn = -1
            }
        }
    }
    
    return (symbols, numbers)
}

//MARK: Problem 1
func firstProblem(elements: (symbols: [EngineElement], numbers: [EngineElement])) -> Int {

    var results: [String: EngineElement] = [:]

    for symbol in elements.symbols {
        for number in elements.numbers {
            if number.row >= symbol.row - 1, number.row <= symbol.row + 1 {
                let min = number.column - 1
                let max = number.column + number.data.count
                if symbol.column >= min, symbol.column <= max {
                    results[number.id.uuidString] = number
                }
                
            }
        }
    }

    let elementsToSum = results.values.compactMap({Int($0.data) ?? 0})
    return elementsToSum.reduce(0, +)
}

//MARK: Problem 2
func secondProblem(elements: (symbols: [EngineElement], numbers: [EngineElement])) -> Int {

    var results: [Int] = []

    for symbol in elements.symbols {
        if symbol.data != "*" {
            continue
        }
        
        var gear: [Int] = []
        for number in elements.numbers {
            if number.row >= symbol.row - 1, number.row <= symbol.row + 1 {
                let min = number.column - 1
                let max = number.column + number.data.count
                if symbol.column >= min, symbol.column <= max {
                    gear.append(Int(number.data) ?? 1)
                }
                
            }
        }
        if gear.count == 2 {
            results.append(gear.reduce(1, *))
        }
    }

    return results.reduce(0, +)
}

let elements = mapElements()
let first = firstProblem(elements: elements)
let second = secondProblem(elements: elements)


