import Foundation

//MARK: Problem 1
struct Point: Hashable {
    let x: Int
    let y: Int
}

var map:[[Character]] = []
var points:Set<Point> = []
var path: Set<Point> = []

func setLeft(_ point: Point, contains: Bool = true) -> Bool {
    if point.y - 1 < 0 { return false }
    if contains, path.contains(Point(x: point.x, y: point.y-1)) { return false }
    switch map[point.x][point.y-1] {
    case "L", "F", "-":
        points.insert(Point(x: point.x, y: point.y-1))
        path.insert(Point(x: point.x, y: point.y-1))
        return true
    default:
        return false
    }
}

func setRight(_ point: Point, contains: Bool = true) -> Bool {
    if point.y + 1 >= map[point.x].count { return false }
    if contains, path.contains(Point(x: point.x, y: point.y+1)) { return false }
    switch map[point.x][point.y+1] {
    case "J", "-", "7":
        points.insert(Point(x: point.x, y: point.y+1))
        path.insert(Point(x: point.x, y: point.y+1))
        return true
    default:
        return false
    }
}

func setTop(_ point: Point, contains: Bool = true) -> Bool {
    if point.x - 1 < 0 { return false }
    if contains, path.contains(Point(x: point.x-1, y: point.y)) { return false }
    switch map[point.x-1][point.y] {
    case "|", "F", "7":
        points.insert(Point(x: point.x-1, y: point.y))
        path.insert(Point(x: point.x-1, y: point.y))
        return true
    default:
        return false
    }
}
func setBottom(_ point: Point, contains: Bool = true) -> Bool {
    if point.x + 1 >= map.count { return false }
    if contains, path.contains(Point(x: point.x+1, y: point.y)) { return false }
    switch map[point.x+1][point.y] {
    case "|", "J", "L":
        points.insert(Point(x: point.x+1, y: point.y))
        path.insert(Point(x: point.x+1, y: point.y))
        return true
    default:
        return false
    }
}

func problem1() -> Int {
    map = ReadFile().read(file: "problem_01").compactMap({Array($0)})
    
    guard let animalRow = map.firstIndex(where: {$0.contains("S")}) else { return 0 }
    guard let animalCol = map[animalRow].firstIndex(where: {$0 == "S"}) else { return 0 }
    
    points.insert(Point(x: animalRow, y: animalCol))
    path = points
    
    while !points.isEmpty {
        let point = points.removeFirst()
        switch map[point.x][point.y] {
        case "S":
            if setLeft(point, contains: false) || setRight(point, contains: false) || setTop(point, contains: false) || setBottom(point, contains: false) {
                continue
            }
        case "L":
            if setRight(point) || setTop(point) {
                continue
            }
        case "J":
            if setLeft(point) || setTop(point) {
                continue
            }
        case "F":
            if setRight(point) || setBottom(point) {
                continue
            }
        case "7":
            if setLeft(point) || setBottom(point) {
                continue
            }
        case "|":
            if setBottom(point) || setTop(point) {
                continue
            }
        case "-":
            if setLeft(point) || setRight(point) {
                continue
            }
        default:
            break
        }
    }
    
    return path.count / 2
}

//MARK: Problem 2
func problem2() -> Int {
    //Solution using ray casting algorith https://en.wikipedia.org/wiki/Point_in_polygon
    map = ReadFile().read(file: "problem_01").compactMap({Array($0)})
    
    guard let animalRow = map.firstIndex(where: {$0.contains("S")}) else { return 0 }
    guard let animalCol = map[animalRow].firstIndex(where: {$0 == "S"}) else { return 0 }
    
    points.insert(Point(x: animalRow, y: animalCol))
    path = points
    
    while !points.isEmpty {
        let point = points.removeFirst()
        switch map[point.x][point.y] {
        case "S":
            if setLeft(point, contains: false) || setRight(point, contains: false) || setTop(point, contains: false) || setBottom(point, contains: false) {
                continue
            }
        case "L":
            if setRight(point) || setTop(point) {
                continue
            }
        case "J":
            if setLeft(point) || setTop(point) {
                continue
            }
        case "F":
            if setRight(point) || setBottom(point) {
                continue
            }
        case "7":
            if setLeft(point) || setBottom(point) {
                continue
            }
        case "|":
            if setBottom(point) || setTop(point) {
                continue
            }
        case "-":
            if setLeft(point) || setRight(point) {
                continue
            }
        default:
            break
        }
    }
    
    var distanceMap: [[Int]] = map.compactMap({$0.compactMap({_ in return -1})})
    for point in path {
        distanceMap[point.x][point.y] = 0
    }
    
    var insidePoints = 0
    for row in 0..<distanceMap.count {
        for col in 0..<distanceMap[row].count {
            if distanceMap[row][col] == -1 {
                var inside = false
                for subCol in stride(from: col, to: 0, by: -1) {
                    if distanceMap[row][subCol] == 0 {
                        switch map[row][subCol] {
                        case "J","L", "S", "|":
                            inside = !inside
                        default:
                            break
                        }
                    }
                }
                if inside {
                    insidePoints += 1
                }
            }
        }
    }
    return insidePoints
}

let first = problem1()
let second = problem2()
