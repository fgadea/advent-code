import Foundation

//| is a vertical pipe connecting north and south.
//- is a horizontal pipe connecting east and west.
//L is a 90-degree bend connecting north and east.
//J is a 90-degree bend connecting north and west.
//7 is a 90-degree bend connecting south and west.
//F is a 90-degree bend connecting south and east.
//. is ground; there is no pipe in this tile.
//S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.

//MARK: Problems 1 & 2
func problem1() -> Int {
    var map = ReadFile().read(file: "problem_01").compactMap({Array($0)})
    var distanceMap: [[Int]] = map.compactMap({$0.compactMap({_ in return -1})})
    
    
    guard let animalRow = map.firstIndex(where: {$0.contains("S")}) else { return 0 }
    guard let animalIndex = map[animalRow].firstIndex(where: {$0 == "S"}) else { return 0 }
    
    distanceMap[animalRow][animalIndex] = 0
    
    var row: Int = -1
    var column: Int = -1
    var previous:Character = "S"
    if animalIndex - 1 >= 0 {
        let leftElement = map[animalRow][animalIndex-1]
        switch leftElement {
        case "F", "-", "L":
            row = animalRow - 1
            column = animalIndex + 1
            distanceMap[animalRow][animalIndex-1] = 1
            previous = leftElement
        default:
            break
        }
    }
    if animalIndex + 1 < map[animalRow].count, row < 0, column < 0 {
        let rightElement = map[animalRow][animalIndex+1]
        switch rightElement {
        case "J", "-", "7":
            row = animalRow
            column = animalIndex + 1
            distanceMap[animalRow][animalIndex+1] = 1
            previous = rightElement
        default:
            break
        }
        
    }
    if animalRow - 1 >= 0, row < 0, column < 0 {
        let topElement = map[animalRow-1][animalIndex]
        switch topElement {
        case "|", "F", "7":
            row = animalRow - 1
            column = animalIndex
            distanceMap[animalRow-1][animalIndex] = 1
            previous = topElement
        default:
            break
        }
    }
    if animalRow + 1 < map.count, row < 0, column < 0 {
        let bottomElement = map[animalRow+1][animalIndex]
        switch bottomElement {
        case "|", "J", "L":
            row = animalRow + 1
            column = animalIndex
            distanceMap[animalRow+1][animalIndex] = 1
            previous = bottomElement
        default:
            break
        }
    }
    
    var count  = 1
    while true {
        count += 1
        switch previous {
        case "L":
            if column + 1 < distanceMap[row].count, distanceMap[row][column + 1] == -1 {
                switch map[row][column + 1] {
                case "7", "-", "J":
                    distanceMap[row][column + 1] = count
                    previous = map[row][column + 1]
                    column = column + 1
                default:
                    return 0
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "7", "|", "F":
                    distanceMap[row - 1][column] = count
                    previous = map[row - 1][column]
                    row = row - 1
                default:
                    return 0
                }
            } else {
                return count
            }
        case "F":
            if column + 1 < distanceMap[row].count, distanceMap[row][column + 1] == -1 {
                switch map[row][column + 1] {
                case "7", "-", "J":
                    distanceMap[row][column + 1] = count
                    previous = map[row][column + 1]
                    column = column + 1
                default:
                    return 0
                }
            } else if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = count
                    previous = map[row + 1][column]
                    row = row + 1
                default:
                    return 0
                }
            } else {
                return count
            }
        case "7":
            if column - 1 >= 0, distanceMap[row][column - 1] == -1 {
                switch map[row][column - 1] {
                case "L", "-", "F":
                    distanceMap[row][column - 1] = count
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    return 0
                }
            } else if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = count
                    previous = map[row + 1][column]
                    row = row + 1
                default:
                    return 0
                }
            } else {
                return count
            }
        case "J":
            if column - 1 >= 0, distanceMap[row][column - 1] == -1 {
                switch map[row][column - 1] {
                case "L", "-", "F":
                    distanceMap[row][column - 1] = count
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    return 0
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "F", "|", "7":
                    distanceMap[row - 1][column] = count
                    previous = map[row - 1][column]
                    row = row - 1
                default:
                    return 0
                }
            } else {
                return count
            }
        case "|":
            if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = count
                    previous = map[row + 1][column]
                    row = row + 1
                default:
                    return 0
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "F", "|", "7":
                    distanceMap[row - 1][column] = count
                    previous = map[row - 1][column]
                    row = row - 1
                default:
                    return 0
                }
            } else {
                return count
            }
        case "-":
            if column - 1 >= 0, distanceMap[row][column - 1] == -1 {
                switch map[row][column - 1] {
                case "L", "-", "F":
                    distanceMap[row][column - 1] = count
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    return 0
                }
            } else if column + 1 < distanceMap[row].count, distanceMap[row][column + 1] == -1 {
                switch map[row][column + 1] {
                case "7", "-", "J":
                    distanceMap[row][column + 1] = count
                    previous = map[row][column + 1]
                    column = column + 1
                default:
                    return 0
                }
            } else {
                return count
            }
        default:
            return 0
        }
        
    }
    return 0
}


func problem2() -> Int {
    let sequences = ReadFile().read(file: "problem_01").compactMap({$0.split(separator: " ")})
        return 0
}

let first = problem1() / 2
let second = problem2()
