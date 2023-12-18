import Foundation

func expand(_ universe:[[Character]]) -> [[Character]] {
    var expandedUniverse:[[Character]] = []
    for row in universe {
        if row.contains("#") {
            expandedUniverse.append(row)
            continue
        }
        expandedUniverse.append(row)
        expandedUniverse.append(row)
    }
    
    var col: Int = 0
    while col < expandedUniverse[0].count {
        var containsGalaxies = false
        for row in 0..<expandedUniverse.count {
            if expandedUniverse[row][col] == "#" {
                containsGalaxies = true
                break
            }
        }
        if !containsGalaxies {
            for row in 0..<expandedUniverse.count {
                expandedUniverse[row].insert(".", at: col)
            }
            col+=1
        }
        col += 1
    }
    
    return expandedUniverse
}

func getExpands(_ universe:[[Bool]]) -> (columns: [Int],rows: [Int]) {
    var columns:[Int] = []
    var rows: [Int] = []
    for (index, row) in universe.enumerated() {
        if !row.contains(true) {
            rows.append(index)
        }
    }
    
    var col: Int = 0
    while col < universe[0].count {
        var containsGalaxies = false
        for row in 0..<universe.count {
            if universe[row][col] == true {
                containsGalaxies = true
                break
            }
        }
        if !containsGalaxies {
            columns.append(col)
        }
        col += 1
    }
    
    return (columns, rows)
}

//MARK: Problem 1
func problem1() -> Int {
    var universe = ReadFile().read(file: "problem_01").compactMap({Array($0)})
    let galaxiesCount = universe.compactMap({$0.compactMap({val in val == "#" ? "#" : nil}).count}).reduce(0, +)
    universe = expand(universe)
    var galaxiesPoints:[Int:(x: Int, y: Int)] = [:]
    for galaxy in 1...galaxiesCount {
        guard let index = universe.firstIndex(where: {$0.contains("#")}) else {
            continue
        }
        guard let colIndex = universe[index].firstIndex(where: {$0 == "#"}) else {
            continue
        }
        universe[index][colIndex] = "x"
        galaxiesPoints[galaxy] = (index, colIndex)
    }
    
    var steps: Int = 0
    for aGalaxy in 1..<galaxiesCount {
        for bGalaxy in aGalaxy+1...galaxiesCount {
            guard let originPoint = galaxiesPoints[aGalaxy] else {
                return 0
            }
            guard let destinationPoint = galaxiesPoints[bGalaxy] else {
                return 0
            }
            
            steps += abs(destinationPoint.x - originPoint.x)
            steps += abs(destinationPoint.y - originPoint.y)
        }
    }
    
    return steps
}

//MARK: Problem 2
func problem2() -> Int {
    var universe = ReadFile().read(file: "problem_01").compactMap({Array($0.compactMap({$0 == "." ? false : true }))})
    let galaxiesCount = universe.compactMap({$0.compactMap({val in val == true ? val : nil}).count}).reduce(0, +)
    let colsAndRows = getExpands(universe)
    var galaxiesPoints:[Int:(x: Int, y: Int)] = [:]
    for galaxy in 1...galaxiesCount {
        guard let index = universe.firstIndex(where: {$0.contains(true)}) else {
            continue
        }
        guard let colIndex = universe[index].firstIndex(where: {$0 == true}) else {
            continue
        }
        universe[index][colIndex] = false
        galaxiesPoints[galaxy] = (index, colIndex)
    }
    
    var steps: Int = 0
    for aGalaxy in 1..<galaxiesCount {
        for bGalaxy in aGalaxy+1...galaxiesCount {
            guard let originPoint = galaxiesPoints[aGalaxy] else {
                return 0
            }
            guard let destinationPoint = galaxiesPoints[bGalaxy] else {
                return 0
            }
            
            let destX = destinationPoint.x - originPoint.x
            if destX > 0 {
                for row in originPoint.x+1...destinationPoint.x {
                    if colsAndRows.rows.contains(row) {
                        steps += 999999
                    }
                    steps += 1
                }
            } else if destX < 0 {
                for row in stride(from: originPoint.x, to: destinationPoint.x, by: -1) {
                    if colsAndRows.rows.contains(row) {
                        steps += 999999
                    }
                    steps += 1
                }
            } else {
                steps += abs(destinationPoint.x - originPoint.x)
            }
            
            let destY = destinationPoint.y - originPoint.y
            if destY > 0 {
                for col in originPoint.y+1...destinationPoint.y {
                    if colsAndRows.columns.contains(col) {
                        steps += 999999
                    }
                    steps += 1
                }
            } else if destY < 0 {
                for col in stride(from: originPoint.y, to: destinationPoint.y, by: -1) {
                    if colsAndRows.columns.contains(col) {
                        steps += 999999
                    }
                    steps += 1
                }
            } else {
                steps += abs(destinationPoint.y - originPoint.y)
            }
            
        }
    }
    return steps
}

//let first = problem1()
//print(first)
let second = problem2()
