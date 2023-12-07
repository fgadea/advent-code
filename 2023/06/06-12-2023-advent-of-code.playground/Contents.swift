import Foundation

//MARK: Problem 1
func firstProblem() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    let timeData = lines[0].split(separator: ":")[1].split(separator: " ").compactMap({Int($0)})
    let distanceData = lines[1].split(separator: ":")[1].split(separator: " ").compactMap({Int($0)})
    
    var races: [(time: Int, distance: Int)] = []
    for (index, time) in timeData.enumerated() {
        races.append((time, distanceData[index]))
    }
    
    var maxDistancePerRace: [Int: Int] = [:]
    for (index, race) in races.enumerated() {
        for milisecond in 0...race.time {
            let raceTime = race.time - milisecond
            let distacePerMili = milisecond
            if distacePerMili * raceTime > race.distance {
                var prevDistances = maxDistancePerRace[index] ?? 0
                maxDistancePerRace[index] = prevDistances + 1
            }
        }
    }
    
    return maxDistancePerRace.values.reduce(1, *)
}

//MARK: Problem 2
func secondProblem() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    let timeRawData = String(lines[0].split(separator: ":")[1]).replacingOccurrences(of: " ", with: "")
    let distanceRawData = String(lines[1].split(separator: ":")[1]).replacingOccurrences(of: " ", with: "")
    let time = Int(timeRawData) ?? 0
    let distance = Int(distanceRawData) ?? 0
    
    
    var startIndex: Int = 0
    var endIndex: Int = 0
    var index: Int = distance / time
    
    var tempIndex = index
    var tempTime = time
    
    while tempIndex < tempTime {
        if tempIndex * (time - tempIndex) > distance {
            startIndex = tempIndex
            break
        }
        tempIndex += 1
    }
    
    tempIndex = time - startIndex
    tempTime = index
    while tempIndex > tempTime {
        if tempIndex * (time - tempIndex) > distance {
            endIndex = tempIndex
            break
        }
        tempIndex -= 1
    }
    
    
    
    return endIndex - startIndex + 1
}

let first = firstProblem()
let second = secondProblem()

