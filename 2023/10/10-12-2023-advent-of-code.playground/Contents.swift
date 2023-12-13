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
    var founded = false
    while !founded {
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
                    founded = true
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "7", "|", "F":
                    distanceMap[row - 1][column] = count
                    previous = map[row - 1][column]
                    row = row - 1
                default:
                    founded = true
                }
            } else {
                founded = true
            }
        case "F":
            if column + 1 < distanceMap[row].count, distanceMap[row][column + 1] == -1 {
                switch map[row][column + 1] {
                case "7", "-", "J":
                    distanceMap[row][column + 1] = count
                    previous = map[row][column + 1]
                    column = column + 1
                default:
                    founded = true
                }
            } else if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = count
                    previous = map[row + 1][column]
                    row = row + 1
                default:
                    founded = true
                }
            } else {
                founded = true
            }
        case "7":
            if column - 1 >= 0, distanceMap[row][column - 1] == -1 {
                switch map[row][column - 1] {
                case "L", "-", "F":
                    distanceMap[row][column - 1] = count
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    founded = true
                }
            } else if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = count
                    previous = map[row + 1][column]
                    row = row + 1
                default:
                    founded = true
                }
            } else {
                founded = true
            }
        case "J":
            if column - 1 >= 0, distanceMap[row][column - 1] == -1 {
                switch map[row][column - 1] {
                case "L", "-", "F":
                    distanceMap[row][column - 1] = count
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    founded = true
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "F", "|", "7":
                    distanceMap[row - 1][column] = count
                    previous = map[row - 1][column]
                    row = row - 1
                default:
                    founded = true
                }
            } else {
                founded = true
            }
        case "|":
            if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = count
                    previous = map[row + 1][column]
                    row = row + 1
                default:
                    founded = true
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "F", "|", "7":
                    distanceMap[row - 1][column] = count
                    previous = map[row - 1][column]
                    row = row - 1
                default:
                    founded = true
                }
            } else {
                founded = true
            }
        case "-":
            if column - 1 >= 0, distanceMap[row][column - 1] == -1 {
                switch map[row][column - 1] {
                case "L", "-", "F":
                    distanceMap[row][column - 1] = count
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    founded = true
                }
            } else if column + 1 < distanceMap[row].count, distanceMap[row][column + 1] == -1 {
                switch map[row][column + 1] {
                case "7", "-", "J":
                    distanceMap[row][column + 1] = count
                    previous = map[row][column + 1]
                    column = column + 1
                default:
                    founded = true
                }
            } else {
                founded = true
            }
        default:
            founded = true
        }
        
    }
    
    var newRow = animalRow
    var newColumn = animalIndex
    
    founded = false
    count = 0
//    -1,-1  -1, 0  -1, 1
//     0,-1   0, 0   0, 1
//     1,-1   1, 0   1, 1
    while !founded {
        if count > 0 && distanceMap[newRow][newColumn] == 0 {
            founded = true
            break
        }
        
        var topLeft = 0
        var midLeft = 0
        var bottomLeft = 0
        if newColumn - 1 >= 0 {
            if newRow - 1 >= 0 {
                topLeft = distanceMap[newRow-1][newColumn-1]
            }
            midLeft = distanceMap[newRow][newColumn-1]
            if newRow + 1 < distanceMap.count {
                bottomLeft = distanceMap[newRow+1][newColumn-1]
            }
        }
        
        var topRight = 0
        var midRight = 0
        var bottomRight = 0
        if newColumn + 1 < distanceMap[newRow].count {
            if newRow - 1 >= 0 {
                topRight = distanceMap[newRow-1][newColumn+1]
            }
            midRight = distanceMap[newRow][newColumn+1]
            if newRow + 1 < distanceMap.count {
                bottomRight = distanceMap[newRow+1][newColumn+1]
            }
        }
        
        var topCenter = 0
        var midCenter = 0
        var bottomCenter = 0
        if newRow - 1 >= 0 {
            topCenter = distanceMap[newRow-1][newColumn]
        }
        if newRow + 1 < distanceMap.count {
            bottomCenter = distanceMap[newRow+1][newColumn]
        }
        
        if topCenter > 0, topCenter == midCenter + 1 {
            if midRight > 0, midRight == midCenter - 1 {
                if topRight == -1 {
                    topRight = -2
                }
                if topLeft == -1 {
                    topLeft = -3
                }
                if midLeft == -1 {
                    midLeft = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -3
                }
                if bottomCenter == -1 {
                    bottomCenter = -3
                }
            } else if midLeft > 0, midLeft == midCenter - 1 {
                if topRight == -1 {
                    topRight = -2
                }
                if topLeft == -1 {
                    topLeft = -3
                }
                if midRight == -1 {
                    midRight = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -3
                }
                if bottomCenter == -1 {
                    bottomCenter = -3
                }
                
            } else if bottomCenter > 0, bottomCenter == midCenter - 1 {
                if topRight == -1 {
                    topRight = -3
                }
                if topLeft == -1 {
                    topLeft = -2
                }
                if midRight == -1 {
                    midRight = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -2
                }
                if bottomRight == -1 {
                    bottomRight = -3
                }
                if midLeft == -1 {
                    midLeft = -2
                }
            }
        } else if midRight > 0, midRight == midCenter + 1 {
            if topCenter > 0, topCenter == midCenter - 1 {
                    if topRight == -1 {
                        topRight = -2
                    }
                    if topLeft == -1 {
                        topLeft = -3
                    }
                    if midLeft == -1 {
                        midLeft = -3
                    }
                    if bottomLeft == -1 {
                        bottomLeft = -3
                    }
                    if bottomRight == -1 {
                        bottomRight = -3
                    }
                    if bottomCenter == -1 {
                        bottomCenter = -3
                    }
            } else if midLeft > 0, midLeft == midCenter - 1 {
                if topRight == -1 {
                    topRight = -2
                }
                if topLeft == -1 {
                    topLeft = -2
                }
                if topCenter == -1 {
                    topCenter = -2
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -3
                }
                if bottomCenter == -1 {
                    bottomCenter = -3
                }
                
            } else if bottomCenter > 0, bottomCenter == midCenter - 1 {
                if topRight == -1 {
                    topRight = -3
                }
                if topLeft == -1 {
                    topLeft = -3
                }
                if topCenter == -1 {
                    topCenter = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -2
                }
                if midLeft == -1 {
                    midLeft = -3
                }
                
            }
        } else if midLeft > 0, midLeft == midCenter + 1 {
            if topCenter > 0, topCenter == midCenter - 1 {
                if topRight == -1 {
                    topRight = -3
                }
                if topLeft == -1 {
                    topLeft = -2
                }
                if midRight == -1 {
                    midRight = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -3
                }
                if bottomCenter == -1 {
                    bottomCenter = -3
                }
            } else if midRight > 0, midRight == midCenter - 1 {
                if topRight == -1 {
                    topRight = -2
                }
                if topLeft == -1 {
                    topLeft = -2
                }
                if topCenter == -1 {
                    topCenter = -2
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -3
                }
                if bottomCenter == -1 {
                    bottomCenter = -3
                }
            } else if bottomCenter > 0, bottomCenter == midCenter - 1 {
                    if topRight == -1 {
                        topRight = -3
                    }
                    if topLeft == -1 {
                        topLeft = -3
                    }
                    if topCenter == -1 {
                        topCenter = -3
                    }
                    if bottomLeft == -1 {
                        bottomLeft = -3
                    }
                    if bottomRight == -1 {
                        bottomRight = -2
                    }
                    if midRight == -1 {
                        midRight = -3
                    }
            }
        } else if bottomCenter > 0, bottomCenter == midCenter + 1 {
            if topCenter > 0, topCenter == midCenter - 1 {
                if topRight == -1 {
                    topRight = -3
                }
                if topLeft == -1 {
                    topLeft = -2
                }
                if midRight == -1 {
                    midRight = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -2
                }
                if bottomRight == -1 {
                    bottomRight = -3
                }
                if midLeft == -1 {
                    midLeft = -2
                }
            } else if midRight > 0, midRight == midCenter - 1 {
                if topRight == -1 {
                    topRight = -3
                }
                if topLeft == -1 {
                    topLeft = -3
                }
                if topCenter == -1 {
                    topCenter = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -2
                }
                if midLeft == -1 {
                    midLeft = -3
                }
            } else if midLeft > 0, midLeft == midCenter - 1 {
                if topRight == -1 {
                    topRight = -3
                }
                if topLeft == -1 {
                    topLeft = -3
                }
                if topCenter == -1 {
                    topCenter = -3
                }
                if bottomLeft == -1 {
                    bottomLeft = -3
                }
                if bottomRight == -1 {
                    bottomRight = -2
                }
                if midRight == -1 {
                    midRight = -3
                }
            }
        }
        
        if newColumn - 1 >= 0 {
            if newRow - 1 >= 0, topLeft < 0 {
                distanceMap[newRow-1][newColumn-1] = topLeft
            }
            if midLeft < 0 {
                distanceMap[newRow][newColumn-1] = midLeft
            }
            if newRow + 1 < distanceMap.count, bottomLeft < 0 {
                distanceMap[newRow+1][newColumn-1] = bottomLeft
            }
        }
        
        if newColumn + 1 < distanceMap[newRow].count {
            if newRow - 1 >= 0, topRight < 0 {
                distanceMap[newRow-1][newColumn+1] = topRight
            }
            if midRight < 0 {
                midRight = distanceMap[newRow][newColumn+1]
            }
            if newRow + 1 < distanceMap.count, bottomRight < 0 {
                distanceMap[newRow+1][newColumn+1] = bottomRight
            }
        }
        
        if newRow - 1 >= 0, topCenter < 0 {
            distanceMap[newRow-1][newColumn] = topCenter
        }
        if newRow + 1 < distanceMap.count, bottomCenter < 0 {
            distanceMap[newRow+1][newColumn] = bottomCenter
        }
        
        count += 1
    }
    
    print(map)
    
    let lines = distanceMap.filter({$0.contains(-2)})
    var count2 = 0
    for line in lines {
        count2 += line.filter({$0 == -2}).count
    }
    
    print(count2)
    return count
}

//let first = problem1() / 2
let second = problem2()
