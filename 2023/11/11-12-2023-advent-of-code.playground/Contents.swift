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

func expand2(_ universe:[[Bool]]) -> [[Bool]] {
    var expandedUniverse:[[Bool]] = []
    for row in universe {
        if row.contains(true) {
            expandedUniverse.append(row)
            continue
        }
        
        for _ in 0..<1000000 {
            expandedUniverse.append(row)
        }
    }
    
    var col: Int = 0
    while col < expandedUniverse[0].count {
        var containsGalaxies = false
        for row in 0..<expandedUniverse.count {
            if expandedUniverse[row][col] == true {
                containsGalaxies = true
                break
            }
        }
        if !containsGalaxies {
            for _ in 0..<999999 {
                for row in 0..<expandedUniverse.count {
                    expandedUniverse[row].insert(false, at: col)
                }
            }
            
            col+=999999
        }
        col += 1
    }
    
    return expandedUniverse
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
    universe = expand2(universe)
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
            
            steps += abs(destinationPoint.x - originPoint.x)
            steps += abs(destinationPoint.y - originPoint.y)
        }
    }
    return steps
}

let first = problem1()
//print(first)
//let second = problem2()
