import Foundation

//MARK: Problem 1
func problem1() -> Int {
    let dataAndPatterns: [(data: String, pattern: String)] = ReadFile().read(file: "problem_01").compactMap({
        let splited = $0.split(separator: " ")
        return (String(splited[0]), String(splited[1]))
    })
    
    for dataAndPattern in dataAndPatterns {
        let data = dataAndPattern.data
        let pattern = dataAndPattern.pattern.split(separator: ",").compactMap({Int($0)})
        for number in pattern {
            var count = 0
            let strings = data.split(separator: ".")
            for string in strings {
                if string.count == number {
                    break
                }
            }
        }
    }
    
    return 0
}

//MARK: Problem 2
func problem2() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    
    for part2 in [false, true] {
        var totalScore = 0
        
        for line in lines {
            let parts = line.components(separatedBy: " ")
            var dots = Array(parts[0])
            var blocks = parts[1].split(separator: ",").compactMap { Int($0) }
            
            if part2 {
                dots += Array(repeating: "?", count: 5 * dots.count - 1)
                blocks += Array(repeating: blocks, count: 5).flatMap { $0 }
            }
            
            var memo = [String: Int]()
            let score = countPossibilities(dots: dots, blocks: blocks, i: 0, bi: 0, current: 0, memo: &memo)
            
            totalScore += score
        }
        
        print(totalScore)
    }
    return 0
}

func countPossibilities(dots: [Character], blocks: [Int], i: Int, bi: Int, current: Int, memo: inout [String: Int]) -> Int {
    let key = "\(i)-\(bi)-\(current)"
        
        if let cachedResult = memo[key] {
            return cachedResult
        }
        
        if i == dots.count {
            if bi == blocks.count && current == 0 {
                return 1
            } else if bi == blocks.count - 1 && blocks[bi] == current {
                return 1
            } else {
                return 0
            }
        }
        
        var result = 0
        
        for c in [Character(".") , Character("#")] {
            if dots[i] == c || dots[i] == "?" {
                if c == "." && current == 0 {
                    result += countPossibilities(dots: dots, blocks: blocks, i: i + 1, bi: bi, current: 0, memo: &memo)
                } else if c == "." && current > 0 && bi < blocks.count && blocks[bi] == current {
                    result += countPossibilities(dots: dots, blocks: blocks, i: i + 1, bi: bi + 1, current: 0, memo: &memo)
                } else if c == "#" {
                    result += countPossibilities(dots: dots, blocks: blocks, i: i + 1, bi: bi, current: current + 1, memo: &memo)
                }
            }
        }
        
        memo[key] = result
        return result
}

//let first = problem1()
//print(first)
//let second = problem2()


enum Spring {
    case Unknown
    case Damaged
    case Operational
}

struct Record {
    var springs: [Spring]
    var counts: [Int]
}

extension Record {
    func isValid() -> Bool {
        let groupedSprings = Dictionary(grouping: springs, by: { $0 })
        let damagedCount = groupedSprings[.Damaged]?.count ?? 0
        return groupedSprings.allSatisfy { key, group in
            key == .Damaged ? group.count == counts[damagedCount] : true
        }
    }

    func validArrangements() -> Int {
        if let index = springs.firstIndex(where: { $0 == .Unknown }) {
            var asDamagedSpring = springs
            asDamagedSpring[index] = .Damaged
            let asDamaged = Record(springs: asDamagedSpring, counts: counts)

            var asOperationalSpring = springs
            asOperationalSpring[index] = .Operational
            let asOperational = Record(springs: asOperationalSpring, counts: counts)

            return asDamaged.validArrangements() + asOperational.validArrangements()
        } else {
            return isValid() ? 1 : 0
        }
    }
}


func parse() -> AnyIterator<Record> {
    var lines = ReadFile().read(file: "problem_01").makeIterator()
    
    return AnyIterator {
        if let line = lines.next() {
            let l = line.split(separator: " ")
            let (springsStr, countsStr) = (l[0], l[1])
            
            let springs = springsStr.map { char -> Spring in
                switch char {
                case ".":
                    return .Operational
                case "#":
                    return .Damaged
                case "?":
                    return .Unknown
                default:
                    fatalError("Unexpected character: \(char)")
                }
            }
            
            let counts = countsStr.split(separator: ",").compactMap { Int($0) }
            
            return Record(springs: springs, counts: counts)
        }
        return nil
    }
}

parse().map { $0.validArrangements() }.reduce(0, +)
