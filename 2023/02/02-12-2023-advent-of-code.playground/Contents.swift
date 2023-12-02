import UIKit


//MARK: First Part
func problem1() -> Int {
    let values = ReadFile().read(file: "problem_01")
    
    let redCubes = 12
    let greeCubes = 13
    let blueCubes = 14

    var sucessGames: [Int] = []

    for rawLine in values {
        var imposible: Bool = false
        
        let game = rawLine.split(separator: ":").compactMap({String($0)})
        let gameId = Int(game[0].replacingOccurrences(of: "Game ", with: "")) ?? 0
        let gameParts = game[1].split(separator: ";").compactMap({String($0)})
        for part in gameParts {
            var gameRedCubes = redCubes
            var gameGreeCubes = greeCubes
            var gameBlueCubes = blueCubes
            let colorCubes = part.split(separator: ",").compactMap({String($0)})
            for colorCube in colorCubes {
                let amountAndColor = colorCube.split(separator: " ").compactMap({String($0)})
                let amount = Int(amountAndColor[0]) ?? 0
                switch amountAndColor[1] {
                case "red":
                    gameRedCubes -= amount
                case "green":
                    gameGreeCubes -= amount
                case "blue":
                    gameBlueCubes -= amount
                default:
                    break;
                }
                
                if gameRedCubes < 0 || gameGreeCubes < 0 || gameBlueCubes < 0 {
                    imposible = true
                    break
                }
            }
            
            if imposible {
                break
            }
        }
        
        if !imposible {
            sucessGames.append(gameId)
        }
    }

    return sucessGames.reduce(0, +)
}


//MARK: Second Part
func problem2() -> Int {
    let values = ReadFile().read(file: "problem_02")

    var gameValues: [Int] = []

    for rawLine in values {
        var minRed: [Int] = []
        var minGreen: [Int] = []
        var minBlue: [Int] = []
        
        let game = rawLine.split(separator: ":").compactMap({String($0)})
        let gameId = Int(game[0].replacingOccurrences(of: "Game ", with: "")) ?? 0
        let gameParts = game[1].split(separator: ";").compactMap({String($0)})
        for part in gameParts {
            var gameRedCubes = 0
            var gameGreeCubes = 0
            var gameBlueCubes = 0
            let colorCubes = part.split(separator: ",").compactMap({String($0)})
            for colorCube in colorCubes {
                let amountAndColor = colorCube.split(separator: " ").compactMap({String($0)})
                let amount = Int(amountAndColor[0]) ?? 0
                switch amountAndColor[1] {
                case "red":
                    gameRedCubes += amount
                case "green":
                    gameGreeCubes += amount
                case "blue":
                    gameBlueCubes += amount
                default:
                    continue;
                }
            }
            minRed.append(gameRedCubes)
            minGreen.append(gameGreeCubes)
            minBlue.append(gameBlueCubes)
        }
        
        let max1 = minRed.max() ?? 0
        let max2 = minGreen.max() ?? 0
        let max3 = minBlue.max() ?? 0
        
        gameValues.append(max1 * max2 * max3)
    }

    return gameValues.reduce(0, +)
}

let result1 = problem1()
let result2 = problem2()


