import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var testInput = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""

var input = """
........#.............................................#.........#..............#.......#....................#....................#
......................#........#........................#.............##............................#.#.............#..........#..
....#..................................#..................#.........#....#..............#..#......................#........#...#..
.....#...#...............#................#..........................#......#.....................#.......................#.......
......................................................##.#....#..................................................................#
#....#....................#..................................#.....................................#......................#.......
.......#...........................#.......................#......#...#.................................................#...#.....
....................##..........................#................#..........................#.#..................#....#.........#.
#..................................#...............#...............#.........................#............##......................
.............................#....................................#...............#.........#..........#.......................#..
.................................#............###.......#............##......#...............................#...............#.#..
.#..........................................#.......#.......................##..#........#........#...............#...............
......#...#............#.#..............#...................#..........................................................##.........
#................##....................................................................#........#.................#...#...........
...#..........#..........................##......#....#..............................#......................................#.....
..............................##.#..........................................................#..............................#......
......#...........#....#..................#............#....................................................................#.....
.....................#........................#.......................................................#...........................
...................#.#..........................................................................................#.#...............
.........................................##.........................................................#.......#...###......#........
...............................................................##.......................#..........................#..............
...#...........#.................#..............#......#.....#..........................#....................#....#...............
.................................#................#................#..............................................#.......##.....#
........#..........................#................#.......................#...................#.................................
.............................#.............................#..........#.........................#........#........................
....#................#.#................#...........................................................#...#....#......#......#......
........#..............................#...............................#.................#........................................
...........................................#..#........#...#...........#..#.............#.........................................
.#.................#.#................................#................#.#..................................#........#............
.......#..........................................#.................................................................#.............
...................#....................................................#..#...............................................#......
...#.#........#...#.....#.....................................................................................................#...
......#.........................#......................#.............#.....................#......................................
..........................#............#.................................#..#..........#........#......................#..........
...#..#......#.......................#........................#...................................................................
............#...........#................#..............#.........................................................................
.#........#....#.........................................#........................................#...............................
...#......................##.........#.......#.#...........#................................................#...#.................
...........#......#.........#....#.....#.......................................................#.............#....................
.............#...#..............................................#.........#.....##....................#...#.........#.............
...............#................................#..........................................#.....#.#.........................#...#
................#.....#..#.............#..............#..............#.......#....................................................
......#.........................................................................................................#.........##......
..#...........................#.#...........................................#..#.....#............................................
...#...#..................#..................................#.........#...................#..................................#...
............#..#.....................#.........................................#.......#..................................#.......
...#.......................................................................#.............................#........................
......#..................#....................................#......##...........................................................
.#...............#.....#..........................................................................................#...............
...#.............#.........................#.....................#...#..........#....#............................#...............
...#............................#.......#...........#.........#........#.....#...........#...................................#....
.....................#...................#................................#...............................#......#.........#..##..
.............#........................................................................................#........................##.
.....#.......#.......#............................................................................................................
............................................#................................................................#..............#.....
....#..#......................................................#...................................................#...............
.................................#...##..................#.................................................#....#.................
........#...................................#...#..........................................................#......................
........................#........##...........#.......#........#...................................#..............................
...........#...#...................................................#..............#......#...............#.#..................#...
........#.............................................#...........................................................................
........#................#......#..........#..#........#.#.......#...#........................#..#......................#.......#.
.......#..........................................................................................................#.....#.....#...
......................##....................#.....#.................#...........#.......................#.##..........#......#....
....................................##....................................................................#.................#.....
..#.................................#.#...........#............................................#....#.............................
#...................................#...........................................#............#.........#...............#..........
.......................#.............................................................#..........#...#.............#.....#.........
#..................#.#.............................................................................#.................#............
.....................#......#.......#...........#..........................................^...............................#......
................................#......................#.#.....#..............#..................#....#.#......#....#.............
............................................................................#........#.....................................#......
.............#......................................................#...................................#......##..#....#.........
...............#.................#...................#...............#............................................................
..............#...........#..#...........................................#...................................#..........#.........
..........#...........................#...................#..............#...#.......#..........#...................#.............
.............#.#..................................#....#..#............#.....................#................#...#.....#.........
...................#..........................................................#............##.....................................
...........................................#............#........................................................................#
..#..............................#....#...........................................................................................
..#..#............#...........................#...#...........#............#.....#.................#..............................
....#...................#.........#...............................................................................................
.......#..........................#....................................##........#.................##...#.#........#..#...........
.#........................#....#.......#.....#...................#.............................................#..................
..#...............................................................#................................................#..............
.....#........................................#...................................................................................
..........................................#..........................................................#............................
....................###.........................#............................#...#...........#............#.......................
.....#.....#...............#........#.#....#...................#...........#........#...........#.................................
................................................................................................#...##............................
......................#............#.........................#.......................#.....#...........#...#.#....................
............................#....................#..................#..............#..................................#...........
...........................#...................................#..............................................................#...
..................#................#.....................#...................#........#..............#............................
............#.............#.....................#..................#.........#......................#............#............#...
....#..........................#...............................................................................................#..
................#.....................................#.............................#...........#........................#........
#.##...........#.........................................#...............#..........................................#.#...........
........................................#..............#.....................#............#.....#.................................
.......#....##..#..#.....#........................................................................................................
....##.............#..............................#...............................................................................
.....#........................#.........#..#......#........#......................#.......#..............#..........#.......#.....
..#....#.........................#.#....................#..#.......#.............#..................#........#..................#.
..........##....#........................................................................#........................................
........#......#................................................................................................#................#
.....#.......#...#.............#....................................#..#........................#...#..............#....#.........
.............#...................................................##...#...........................................................
..............#.............................................#.............#................#.............#..............#.........
..#....#..........#.....#......#......................#................................#...............................#..........
.................................................................................##......#...........................#.....#......
..#....#..........#.......#.........................................#...............#..#............................#........#....
...........#........#.#....................#........#.....................................#..................#....................
.......#............#................#...........#.............#......#.........#...........................#.....................
#.#....#.#...............#....#.....#.......................#...............................#...................##...#............
.................##...#.................................................................#...........................#.............
.....#........................................#.........#...................................................#.....................
....................#.....................#................................................#...##.....................#...........
...............#...............................................................#....#.............................................
.................#................#...#.....................................#......#....................#...............#.#.......
...................#............................................#..#....#..#........#...............................#.........#...
..#........#...............#..................#.....#..................#.....................................#........##...#......
.....#.....#....#.....#................#.#.....................##.............................................................#...
................#............#......#......#.......................................................#....................#........#
........#..............#..#......................................................................##.....##........................
.........#.............................#.........#.......................................#..........................#.##..........
.#...................#........................................................#....#......................................#.......
....#..........#.....#.........................................................................................#..................
.......#.............................#............#.........................#....#....#........#......#.....#.......#.............
..#.......#........................#........................#.....................................................................
........................#...............................#.#.............#................................#..................#.....
"""

func getMap(_ data: String) -> [[Character]] {
    data.split(separator: "\n").map({ Array($0) })
}

var map = getMap(input)

// Search patrol
var rowIndex = 0
var columnIndex = 0
for (index, row) in map.enumerated() {
    rowIndex = index
    if let patrol = row.firstIndex(of: "^") {
        columnIndex = row.distance(from: row.startIndex, to: patrol)
        break
    }
}

struct PatrolPosition: Hashable, Equatable {
    var row: Int
    var column: Int
}

var patrollPosition: (row: Int, column: Int) = (rowIndex, columnIndex)
var patrolPositions: Set<PatrolPosition> = []
var rightTurns: [PatrolPosition: Int] = [:]
while true {
    patrolPositions.insert(.init(row: patrollPosition.row, column: patrollPosition.column))
    if map[patrollPosition.row][patrollPosition.column] == "^" {
        if patrollPosition.row - 1 < 0 { break }
        
        if map[patrollPosition.row - 1][patrollPosition.column] == "#" {
            if patrollPosition.column + 1 >= map[patrollPosition.row].count { break }
            
            map[patrollPosition.row][patrollPosition.column + 1] = ">"
            map[patrollPosition.row][patrollPosition.column] = "X"
            patrollPosition = (patrollPosition.row, patrollPosition.column + 1)
            rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
            continue
        }
        
        map[patrollPosition.row - 1][patrollPosition.column] = "^"
        map[patrollPosition.row][patrollPosition.column] = "X"
        patrollPosition = (patrollPosition.row - 1, patrollPosition.column)
        continue
    }
    
    if map[patrollPosition.row][patrollPosition.column] == ">" {
        if patrollPosition.column + 1 >= map[patrollPosition.row].count { break }
        
        if map[patrollPosition.row][patrollPosition.column + 1] == "#" {
            if patrollPosition.row + 1 >= map.count { break }
            
            map[patrollPosition.row + 1][patrollPosition.column] = "v"
            map[patrollPosition.row][patrollPosition.column] = "X"
            patrollPosition = (patrollPosition.row + 1, patrollPosition.column)
            rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
            continue
        }
        
        map[patrollPosition.row][patrollPosition.column + 1] = ">"
        map[patrollPosition.row][patrollPosition.column] = "X"
        patrollPosition = (patrollPosition.row, patrollPosition.column + 1)
        continue
    }
    
    if map[patrollPosition.row][patrollPosition.column] == "<" {
        if patrollPosition.column - 1 < 0 { break }
        
        if map[patrollPosition.row][patrollPosition.column - 1] == "#" {
            if patrollPosition.row - 1 < 0 { break }
            
            map[patrollPosition.row - 1][patrollPosition.column] = "^"
            map[patrollPosition.row][patrollPosition.column] = "X"
            patrollPosition = (patrollPosition.row - 1, patrollPosition.column)
            rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
            continue
        }
        
        map[patrollPosition.row][patrollPosition.column - 1] = "<"
        map[patrollPosition.row][patrollPosition.column] = "X"
        patrollPosition = (patrollPosition.row, patrollPosition.column - 1)
        continue
    }
    
    if map[patrollPosition.row][patrollPosition.column] == "v" {
        if patrollPosition.row + 1 >= map.count { break }
        
        if map[patrollPosition.row + 1][patrollPosition.column] == "#" {
            if patrollPosition.column - 1 < 0 { break }
            
            map[patrollPosition.row][patrollPosition.column - 1] = "<"
            map[patrollPosition.row][patrollPosition.column] = "X"
            patrollPosition = (patrollPosition.row, patrollPosition.column - 1)
            rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
            continue
        }
        
        map[patrollPosition.row + 1][patrollPosition.column] = "v"
        map[patrollPosition.row][patrollPosition.column] = "X"
        patrollPosition = (patrollPosition.row + 1, patrollPosition.column)
        continue
    }
}

print(patrolPositions.count)


//func isLoopMap(_ map: [[Character]], _ initialPatrolPosition: (row: Int, column: Int)) async -> Bool {
//    var patrollPosition = initialPatrolPosition
//    var map = map
//    var rightTurns: [PatrolPosition: Int] = [:]
//    while true {
//        if rightTurns.values.first(where: {$0 >= 2}) != nil {
//            return true
//        }
//        
//        if map[patrollPosition.row][patrollPosition.column] == "^" {
//            if patrollPosition.row - 1 < 0 { break }
//            
//            if map[patrollPosition.row - 1][patrollPosition.column] == "#" {
//                if patrollPosition.column + 1 >= map[patrollPosition.row].count { break }
//                
//                map[patrollPosition.row][patrollPosition.column + 1] = ">"
//                patrollPosition = (patrollPosition.row, patrollPosition.column + 1)
//                rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
//                continue
//            }
//            
//            map[patrollPosition.row - 1][patrollPosition.column] = "^"
//            patrollPosition = (patrollPosition.row - 1, patrollPosition.column)
//            continue
//        }
//        
//        if map[patrollPosition.row][patrollPosition.column] == ">" {
//            if patrollPosition.column + 1 >= map[patrollPosition.row].count { break }
//            
//            if map[patrollPosition.row][patrollPosition.column + 1] == "#" {
//                if patrollPosition.row + 1 >= map.count { break }
//                
//                map[patrollPosition.row + 1][patrollPosition.column] = "v"
//                patrollPosition = (patrollPosition.row + 1, patrollPosition.column)
//                rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
//                continue
//            }
//            
//            map[patrollPosition.row][patrollPosition.column + 1] = ">"
//            patrollPosition = (patrollPosition.row, patrollPosition.column + 1)
//            rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
//            continue
//        }
//        
//        if map[patrollPosition.row][patrollPosition.column] == "<" {
//            if patrollPosition.column - 1 < 0 { break }
//            
//            if map[patrollPosition.row][patrollPosition.column - 1] == "#" {
//                if patrollPosition.row - 1 < 0 { break }
//                
//                map[patrollPosition.row - 1][patrollPosition.column] = "^"
//                patrollPosition = (patrollPosition.row - 1, patrollPosition.column)
//                rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
//                continue
//            }
//            
//            map[patrollPosition.row][patrollPosition.column - 1] = "<"
//            patrollPosition = (patrollPosition.row, patrollPosition.column - 1)
//            continue
//        }
//        
//        if map[patrollPosition.row][patrollPosition.column] == "v" {
//            if patrollPosition.row + 1 >= map.count { break }
//            
//            if map[patrollPosition.row + 1][patrollPosition.column] == "#" {
//                if patrollPosition.column - 1 < 0 { break }
//                
//                map[patrollPosition.row][patrollPosition.column - 1] = "<"
//                patrollPosition = (patrollPosition.row, patrollPosition.column - 1)
//                rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
//                continue
//            }
//            
//            map[patrollPosition.row + 1][patrollPosition.column] = "v"
//            patrollPosition = (patrollPosition.row + 1, patrollPosition.column)
//            continue
//        }
//    }
//    
//    return false
//}
//
//func parallelizedLoopSearch() async -> Int {
//    var loopOptions = 0
//
//    await withTaskGroup(of: Bool.self) { group in
//        let rowIndex = await rowIndex
//        let columnIndex = await columnIndex
//        for (index, position) in await patrolPositions.enumerated() {
//            if position.row == rowIndex, position.column == columnIndex {
//                continue
//            }
//            
//            group.addTask {
//                var newMap = await map
//                newMap[position.row][position.column] = "#"
//                
//                for index in 0..<newMap.count {
//                    newMap[index] = Array(String(newMap[index]).replacing(/X|v|\^|<|>/, with: "."))
//                }
//                
//                newMap[rowIndex][columnIndex] = "^"
//                let result = await isLoopMap(newMap, (rowIndex, columnIndex))
//                return result
//            }
//        }
//        
//        for await result in group {
//            if result {
//                loopOptions += 1
//            }
//        }
//    }
//    
//    return loopOptions
//}

autoreleasepool {
    var loops = 0
    for (index, position) in patrolPositions.enumerated() {
        if position.row == rowIndex, position.column == columnIndex {
            continue
        }
        
        autoreleasepool {
            var newMap = map
            newMap[position.row][position.column] = "#"
            
            for index in 0..<newMap.count {
                newMap[index] = Array(String(newMap[index]).replacing(/X|v|\^|<|>/, with: "."))
            }
            
            newMap[rowIndex][columnIndex] = "^"
            patrollPosition = (rowIndex, columnIndex)
            
            var rightTurns: [PatrolPosition: Int] = [:]
            while true {
                if rightTurns.values.first(where: {$0 >= 2}) != nil {
                    loops += 1
                    break
                }
                
                if newMap[patrollPosition.row][patrollPosition.column] == "^" {
                    if patrollPosition.row - 1 < 0 { break }
                    
                    if newMap[patrollPosition.row - 1][patrollPosition.column] == "#" {
                        if patrollPosition.column + 1 >= newMap[patrollPosition.row].count { break }
                        
                        newMap[patrollPosition.row][patrollPosition.column + 1] = ">"
                        patrollPosition = (patrollPosition.row, patrollPosition.column + 1)
                        rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
                        continue
                    }
                    
                    newMap[patrollPosition.row - 1][patrollPosition.column] = "^"
                    patrollPosition = (patrollPosition.row - 1, patrollPosition.column)
                    continue
                }
                
                if newMap[patrollPosition.row][patrollPosition.column] == ">" {
                    if patrollPosition.column + 1 >= newMap[patrollPosition.row].count { break }
                    
                    if newMap[patrollPosition.row][patrollPosition.column + 1] == "#" {
                        if patrollPosition.row + 1 >= newMap.count { break }
                        
                        newMap[patrollPosition.row + 1][patrollPosition.column] = "v"
                        patrollPosition = (patrollPosition.row + 1, patrollPosition.column)
                        rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
                        continue
                    }
                    
                    newMap[patrollPosition.row][patrollPosition.column + 1] = ">"
                    patrollPosition = (patrollPosition.row, patrollPosition.column + 1)
                    rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
                    continue
                }
                
                if newMap[patrollPosition.row][patrollPosition.column] == "<" {
                    if patrollPosition.column - 1 < 0 { break }
                    
                    if newMap[patrollPosition.row][patrollPosition.column - 1] == "#" {
                        if patrollPosition.row - 1 < 0 { break }
                        
                        newMap[patrollPosition.row - 1][patrollPosition.column] = "^"
                        patrollPosition = (patrollPosition.row - 1, patrollPosition.column)
                        rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
                        continue
                    }
                    
                    newMap[patrollPosition.row][patrollPosition.column - 1] = "<"
                    patrollPosition = (patrollPosition.row, patrollPosition.column - 1)
                    continue
                }
                
                if newMap[patrollPosition.row][patrollPosition.column] == "v" {
                    if patrollPosition.row + 1 >= newMap.count { break }
                    
                    if newMap[patrollPosition.row + 1][patrollPosition.column] == "#" {
                        if patrollPosition.column - 1 < 0 { break }
                        
                        newMap[patrollPosition.row][patrollPosition.column - 1] = "<"
                        patrollPosition = (patrollPosition.row, patrollPosition.column - 1)
                        rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] = (rightTurns[.init(row: patrollPosition.row, column: patrollPosition.column)] ?? 0) + 1
                        continue
                    }
                    
                    newMap[patrollPosition.row + 1][patrollPosition.column] = "v"
                    patrollPosition = (patrollPosition.row + 1, patrollPosition.column)
                    continue
                }
            }
            newMap.removeAll()
        }
    }
    print(loops)
}
