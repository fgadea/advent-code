import UIKit

func getWinningAndNumbers(_ card: String) -> (winning: [Substring], numbers: [Substring]) {
    let cardNumberAndContent = card.split(separator: ":")
    let numbers = cardNumberAndContent[1].split(separator: "|")
    let winningNumbers = numbers[0].split(separator: " ")
    let numbersInCard = numbers[1].split(separator: " ")
    
    return (winningNumbers, numbersInCard)
}
//MARK: Problem 1
func firstProblem() -> Int {
    let cards = ReadFile().read(file: "problem_01")
    
    var result: Int = 0
    for card in cards {
        var numbersMultiplied = 0
        let winningAndNumbers = getWinningAndNumbers(card)
        
        for number in winningAndNumbers.numbers {
            if winningAndNumbers.winning.contains(where: {$0 == number}) {
                if numbersMultiplied == 0 {
                    numbersMultiplied = 1
                } else {
                    numbersMultiplied *= 2
                }
            }
        }
        if numbersMultiplied > 0 {
            result += numbersMultiplied
        }
    }
    
    return result
}

//MARK: Problem 2
func secondProblem() -> Int {
    
    let cards = ReadFile().read(file: "problem_01")
    
    var result: [Int:Int] = [:]
    for (index, card) in cards.enumerated() {
        result[index] = (result[index] ?? 0) + 1
        var numbersMultiplied = 0
        let winningAndNumbers = getWinningAndNumbers(card)
        
        var matches = 0
        for number in winningAndNumbers.numbers {
            if winningAndNumbers.winning.contains(where: {$0 == number}) {
                matches += 1
            }
        }
        
        for match in 0..<matches {
            let elementPosition = index + match + 1
            result[elementPosition] = (result[elementPosition] ?? 0) + (result[index] ?? 0)
        }
    }
    
    return result.values.reduce(0, +)
}

let first = firstProblem()
let second = secondProblem()


