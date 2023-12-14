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
    if previous == "S", animalIndex + 1 < map[animalRow].count {
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
    if previous == "S", animalRow - 1 >= 0 {
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
    if previous == "S", animalRow + 1 < map.count {
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
        switch previous {
        case "L":
            if column + 1 < distanceMap[row].count, distanceMap[row][column + 1] == -1 {
                switch map[row][column + 1] {
                case "7", "-", "J":
                    distanceMap[row][column + 1] = 0
                    previous = map[row][column + 1]
                    column = column + 1
                default:
                    founded = true
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "7", "|", "F":
                    distanceMap[row - 1][column] = 0
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
                    distanceMap[row][column + 1] = 0
                    previous = map[row][column + 1]
                    column = column + 1
                default:
                    founded = true
                }
            } else if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = 0
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
                    distanceMap[row][column - 1] = 0
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    founded = true
                }
            } else if row + 1 < distanceMap.count, distanceMap[row + 1][column] == -1 {
                switch map[row + 1][column] {
                case "J", "|", "L":
                    distanceMap[row + 1][column] = 0
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
                    distanceMap[row][column - 1] = 0
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    founded = true
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "F", "|", "7":
                    distanceMap[row - 1][column] = 0
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
                    distanceMap[row + 1][column] = 0
                    previous = map[row + 1][column]
                    row = row + 1
                default:
                    founded = true
                }
            } else if row - 1 >= 0, distanceMap[row - 1][column] == -1 {
                switch map[row - 1][column] {
                case "F", "|", "7":
                    distanceMap[row - 1][column] = 0
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
                    distanceMap[row][column - 1] = 0
                    previous = map[row][column - 1]
                    column = column - 1
                default:
                    founded = true
                }
            } else if column + 1 < distanceMap[row].count, distanceMap[row][column + 1] == -1 {
                switch map[row][column + 1] {
                case "7", "-", "J":
                    distanceMap[row][column + 1] = 0
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
    
    
    
//    for i in 0..<distanceMap.count {
//        var newRow: [[Int]] = []
//        for j in 0..<distanceMap[i].count {
//            if j - 1 >= 0 {
//                queue.append((node.x, node.y - 1))
//            }
//            if j + 1 < distanceMap[node.x].count {
//                queue.append((node.x, node.y + 1))
//            }
//            if i - 1 >= 0 {
//                queue.append((node.x - 1, node.y))
//            }
//            if i + 1 < distanceMap.count {
//                queue.append((node.x + 1, node.y))
//            }
//            newRow.append([-1, distanceMap[i][j], -1])
//        }
//        distanceMap[i] = newRow.flatMap({$0})
//    }
    
//    Flood-fill (node):
//      1. Set Q to the empty queue or stack.
//      2. Add node to the end of Q.
//      3. While Q is not empty:
//      4.   Set n equal to the first element of Q.
//      5.   Remove first element from Q.
//      6.   If n is Inside:
//             Set the n
//             Add the node to the west of n to the end of Q.
//             Add the node to the east of n to the end of Q.
//             Add the node to the north of n to the end of Q.
//             Add the node to the south of n to the end of Q.
//      7. Continue looping until Q is exhausted.
//      8. Return.
    
    
    var grounds:[(x: Int, y: Int)] = []
    
    for i in 0..<map.count {
        for j in 0..<map[i].count {
            if map[i][j] == "." {
                grounds.append((i,j))
            }
        }
    }
    
    var enclosedGrounds:[(x: Int, y: Int)] = []
    for ground in grounds {
        var x = ground.x
        var y = ground.y
        var t = false
        var tl = false
        var tr = false
        var l = false
        var r = false
        var b = false
        var bl = false
        var br = false
        for right in y+1..<distanceMap.count {
            if distanceMap[x][right] == 0 {
                r = true
            }
        }
        if !r {
            continue
        }
        
        for left in stride(from: y-1, to: 0, by: -1) {
            if distanceMap[x][left] == 0 {
                l = true
            }
        }
        
        if !l {
            continue
        }
        
        for top in stride(from: x-1, to: 0, by: -1) {
            if distanceMap[top][y] == 0 {
                t = true
            }
        }
        if !t {
            continue
        }
        for bottom in x+1..<distanceMap.count {
            if distanceMap[bottom][y] == 0 {
                b = true
            }
        }
        if !b {
            continue
        }
        var ceros = 0
        var lastCero = (0,0)
        for bottom in x+1..<distanceMap.count {
            for right in y+1..<distanceMap.count {
                if distanceMap[bottom][right] == 0 {
                    ceros += 1
                    lastCero = (bottom, right)
                    if lastCero.1 == y+1, ceros == distanceMap.count - (x+2) {
                        br = true
                    }
                    continue
                }
            }
        }
        
        if !br {
            continue
        }
        
        ceros = 0
        lastCero = (0,0)
        
        for bottom in x+1..<distanceMap.count {
            for left in stride(from: y-1, to: 0, by: -1) {
                if distanceMap[bottom][left] == 0 {
                    ceros += 1
                    lastCero = (bottom, left)
                    
                    if lastCero.1 == y-1, ceros == distanceMap.count - (y-2) {
                        bl = true
                    }
                    continue
                }
            }
        }
        
        if !bl {
            continue
        }
        
        ceros = 0
        lastCero = (0,0)
        
        for top in stride(from: x-1, to: 0, by: -1) {
            for left in stride(from: y-1, to: 0, by: -1) {
                if distanceMap[top][left] == 0 {
                    ceros += 1
                    lastCero = (top, left)
                    
                    if lastCero.1 == y-1, ceros == x - 2 {
                        tl = true
                    }
                    continue
                }
            }
        }
        
        if !tl {
            continue
        }
        
        ceros = 0
        lastCero = (0,0)
        
        for top in stride(from: x-1, to: 0, by: -1) {
            for right in y+1..<distanceMap.count {
                if distanceMap[top][right] == 0 {
                    ceros += 1
                    lastCero = (top, right)
                    
                    if lastCero.1 == y+1, ceros == x - 2 {
                        tr = true
                    }
                    continue
                }
            }
        }
        
        if !tr {
            continue
        }
        
        if r, l, t, b, br, bl, tl, tr {
            enclosedGrounds.append(ground)
        }
    }
    
    count = 0
    for enclosedGround in enclosedGrounds {
        var queue:[(x: Int, y: Int)] = [enclosedGround]
    //    queue.append((0, 0))
        print(count)
        while !queue.isEmpty {
            var node = queue.removeFirst()
            if distanceMap[node.x][node.y] <= -1 {
                distanceMap[node.x][node.y] = 1
                count += 1
                if node.y - 1 >= 0 {
                    queue.append((node.x, node.y - 1))
                }
                if node.y + 1 < distanceMap[node.x].count {
                    queue.append((node.x, node.y + 1))
                }
                if node.x - 1 >= 0 {
                    queue.append((node.x - 1, node.y))
                }
                if node.x + 1 < distanceMap.count {
                    queue.append((node.x + 1, node.y))
                }
            }
        }
    }
    
    return count
    
    
//    var interiorPoints = 0
//        var exteriorPoints = 0
//    
//    
//    let rows = distanceMap.count
//    let cols = distanceMap[0].count
//        
//        // Loop through each cell in the matrix
//        for i in 0..<rows {
//            for j in 0..<cols {
//                // Check if the current cell is part of the polygon
//                if distanceMap[i][j] == 0 {
//                    // Count interior points
//                    interiorPoints += 1
//                    
//                    // Check if the cell to the right is also part of the polygon
//                    if j + 1 < cols && distanceMap[i][j + 1] == 0 {
//                        interiorPoints -= 1
//                    }
//                    
//                    // Check if the cell below is also part of the polygon
//                    if i + 1 < rows && distanceMap[i + 1][j] == 0 {
//                        interiorPoints -= 1
//                    }
//                } else if distanceMap[i][j] == -1 {
//                    // Count exterior points
//                    exteriorPoints += 1
//                }
//            }
//        }
//    print(exteriorPoints)
//    return rows * cols + interiorPoints
}

func countEnclosedTiles() -> Int {
    var matrix = ReadFile().read(file: "problem_01").compactMap({Array($0)})
    let rows = matrix.count
    let cols = matrix[0].count
    
    // Helper function to mark enclosed tiles using depth-first search
    func markEnclosed(x: Int, y: Int) {
        if x < 0 || x >= rows || y < 0 || y >= cols || matrix[x][y] != "." {
            return
        }
        
        matrix[x][y] = "I" // Mark tile as inside the loop
        
        // Recursively explore adjacent tiles
        markEnclosed(x: x + 1, y: y)
        markEnclosed(x: x - 1, y: y)
        markEnclosed(x: x, y: y + 1)
        markEnclosed(x: x, y: y - 1)
    }
    
    // Iterate through the matrix and find the starting point for the loop
    for i in 0..<rows {
        for j in 0..<cols {
            if matrix[i][j] == "." {
                markEnclosed(x: i, y: j)
            }
        }
    }
    
    // Count the marked tiles
    var enclosedCount = 0
    for i in 0..<rows {
        for j in 0..<cols {
            if matrix[i][j] == "I" {
                enclosedCount += 1
            }
        }
    }
    
    return enclosedCount
}

//let first = problem1() / 2
let second = problem2()
