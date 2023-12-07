import Foundation

enum Almanacs: String {
    case none
    case seedToSoil = "seed-to-soil map:"
    case soilToFertilizer = "soil-to-fertilizer map:"
    case fertilizerToWater = "fertilizer-to-water map:"
    case waterToLight = "water-to-light map:"
    case lightToTemperature = "light-to-temperature map:"
    case temperatureToHumidity = "temperature-to-humidity map:"
    case humidityToLocation = "humidity-to-location map:"
}

//MARK: Problem 1
func firstProblem() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    var seeds: [Int] = []
    var seedToSoil: [Int: Int] = [:]
    var soilToFertilizer: [Int: Int] = [:]
    var fertilizerToWater: [Int: Int] = [:]
    var waterToLight: [Int: Int] = [:]
    var lightToTemperature: [Int: Int] = [:]
    var temperatureToHumidity: [Int: Int] = [:]
    var humidityToLocation: [Int: Int] = [:]
    var actualAlmanac:Almanacs = .none
    for (index, line) in lines.enumerated() {
        if index == 0 {
            let rawSeed = line.split(separator: ":")[1]
            seeds = rawSeed.split(separator: " ").compactMap({Int($0)})
            continue
        }
        if let almanac = Almanacs(rawValue: line) {
            actualAlmanac = almanac
            continue
        }
        
        let destinationSourceRange = line.split(separator: " ").compactMap({Int($0)})
        let destination = destinationSourceRange[0]
        let source = destinationSourceRange[1]
        let range = destinationSourceRange[2]
        
        let sourceRange = source..<source+range
        
        switch actualAlmanac {
        case .seedToSoil:
            for seed in seeds {
                if sourceRange.contains(seed) {
                    seedToSoil[seed] = destination + sourceRange.distance(from: source, to: seed)
                } else if seedToSoil[seed] == nil {
                    seedToSoil[seed] = seed
                }
            }
        case .soilToFertilizer:
            for value in seedToSoil.values {
                if sourceRange.contains(value) {
                    soilToFertilizer[value] = destination + sourceRange.distance(from: source, to: value)
                } else if soilToFertilizer[value] == nil {
                    soilToFertilizer[value] = value
                }
            }
        case .fertilizerToWater:
            for value in soilToFertilizer.values {
                if sourceRange.contains(value) {
                    fertilizerToWater[value] = destination + sourceRange.distance(from: source, to: value)
                } else if fertilizerToWater[value] == nil {
                    fertilizerToWater[value] = value
                }
            }
        case .waterToLight:
            for value in fertilizerToWater.values {
                if sourceRange.contains(value) {
                    waterToLight[value] = destination + sourceRange.distance(from: source, to: value)
                } else  if waterToLight[value] == nil {
                    waterToLight[value] = value
                }
            }
            
        case .lightToTemperature:
            for value in waterToLight.values {
                if sourceRange.contains(value) {
                    lightToTemperature[value] = destination + sourceRange.distance(from: source, to: value)
                } else if lightToTemperature[value] == nil {
                    lightToTemperature[value] = value
                }
            }
            
        case .temperatureToHumidity:
            for value in lightToTemperature.values {
                if sourceRange.contains(value) {
                    temperatureToHumidity[value] = destination + sourceRange.distance(from: source, to: value)
                } else if temperatureToHumidity[value] == nil {
                    temperatureToHumidity[value] = value
                }
            }
        case .humidityToLocation:
            for value in temperatureToHumidity.values {
                if sourceRange.contains(value) {
                    humidityToLocation[value] = destination + sourceRange.distance(from: source, to: value)
                } else if humidityToLocation[value] == nil {
                    humidityToLocation[value] = value
                }
            }
            
        case .none:
            break
        }
    }
    
    var lowestLocation: Int = Int.max
    for seed in seeds {
        let soil = seedToSoil[seed]!
        let fertilizer = soilToFertilizer[soil]!
        let water = fertilizerToWater[fertilizer]!
        let light = waterToLight[water]!
        let temperature = lightToTemperature[light]!
        let humidity = temperatureToHumidity[temperature]!
        let location = humidityToLocation[humidity]!
        if location <= lowestLocation {
            lowestLocation = location
        }
    }
    
    return lowestLocation
}

//MARK: Problem 2
func secondProblem() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    var seeds: [ClosedRange<Int>] = []
    var seedToSoil: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var soilToFertilizer: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var fertilizerToWater: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var waterToLight: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var lightToTemperature: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var temperatureToHumidity: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var humidityToLocation: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var actualAlmanac:Almanacs = .none
    for (index, line) in lines.enumerated() {
        if index == 0 {
            let rawSeed = line.split(separator: ":")[1]
            let rangeSeeds = rawSeed.split(separator: " ").compactMap({Int($0)})
            
            for i in stride(from: 0, to: rangeSeeds.count, by: 2) {
                seeds.append(rangeSeeds[i]...(rangeSeeds[i] + rangeSeeds[i+1]-1))
            }
            continue
        }
        if let almanac = Almanacs(rawValue: line) {
            actualAlmanac = almanac
            continue
        }
        
        let destinationSourceRange = line.split(separator: " ").compactMap({Int($0)})
        let destination = destinationSourceRange[0]
        let source = destinationSourceRange[1]
        let range = destinationSourceRange[2]
        let difference = destination - source
        
        let sourceRange = source...(source+range-1)
        
        switch actualAlmanac {
        case .seedToSoil:
            seedToSoil[sourceRange] = destination...(destination+range-1)
            break
        case .soilToFertilizer:
            soilToFertilizer[sourceRange] = destination...(destination+range-1)
            break
        case .fertilizerToWater:
            fertilizerToWater[sourceRange] = destination...(destination+range-1)
            break
        case .waterToLight:
            waterToLight[sourceRange] = destination...(destination+range-1)
            break
        case .lightToTemperature:
            lightToTemperature[sourceRange] = destination...(destination+range-1)
            break
        case .temperatureToHumidity:
            temperatureToHumidity[sourceRange] = destination...(destination+range-1)
            break
        case .humidityToLocation:
            humidityToLocation[sourceRange] = destination...(destination+range-1)
            break
        case .none:
            break
        }
    }
    
    var convertedRanges: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    for seed in seeds {
        convertedRanges[seed] = seed
    }
    var processedRanges: [ClosedRange<Int>: Int] = [:]
    var outRanges: [ClosedRange<Int>: ClosedRange<Int>] = [:]
    var operatorRanges: [ClosedRange<Int>] = []
    actualAlmanac = .none
    for _ in 0...6 {
        var values: [ClosedRange<Int>: ClosedRange<Int>] = [:]
        operatorRanges = Array(convertedRanges.keys)
        convertedRanges = [:]
        processedRanges = [:]
        outRanges = [:]
        switch actualAlmanac {
        case .seedToSoil:
            actualAlmanac = .soilToFertilizer
            values = soilToFertilizer
        case .soilToFertilizer:
            actualAlmanac = .fertilizerToWater
            values = fertilizerToWater
        case .fertilizerToWater:
            actualAlmanac = .waterToLight
            values = waterToLight
        case .waterToLight:
            actualAlmanac = .lightToTemperature
            values = lightToTemperature
        case .lightToTemperature:
            actualAlmanac = .temperatureToHumidity
            values = temperatureToHumidity
        case .temperatureToHumidity:
            actualAlmanac = .humidityToLocation
            values = humidityToLocation
        case .humidityToLocation:
            values = humidityToLocation
        case .none:
            actualAlmanac = .seedToSoil
            values = seedToSoil
        }
        
        var index = 0
        while index < operatorRanges.count {
            let range = operatorRanges[index]
            for value in values.keys {
                processedRanges[range] = processedRanges[range] ?? 0
                if range.lowerBound > value.upperBound || range.upperBound < value.lowerBound {
                    outRanges[range] = range
                    continue // out of range at top or bottom
                }
                
                let diff = (values[value]?.lowerBound ?? 0)-value.lowerBound
                
                //inside range, overflow at top
                if range.lowerBound >= value.lowerBound {
                    if range.upperBound <= value.upperBound {//inside range
                        if range.lowerBound+diff != range.upperBound+diff {
                            let newRange = (range.lowerBound+diff)...(range.upperBound+diff)
                            convertedRanges[newRange] = newRange
                        }
                    } else {//overflow at top
                        if value.upperBound+1 != range.upperBound {//overflow range, it is reevaluated
                            let outRange = value.upperBound+1...range.upperBound
                            operatorRanges.append(outRange)
                        }
                        if range.lowerBound+diff != value.upperBound+diff {//range inside
                            let newRange = (range.lowerBound+diff)...(value.upperBound+diff)
                            convertedRanges[newRange] = newRange
                        }
                        
                    }
                } else if range.upperBound <= value.upperBound {//overflow at bottom
                    if value.lowerBound-1 != range.lowerBound {//overflow range, it is reevaluated
                        let outRange = range.lowerBound...value.lowerBound-1
                        operatorRanges.append(outRange)
                    }
                    if value.lowerBound+diff != range.upperBound+diff {//range inside
                        let newRange = (value.lowerBound+diff)...(range.upperBound+diff)
                        convertedRanges[newRange] = newRange
                    }
                } else {//outside range at top and bottom
                    let newRange = (value.lowerBound+diff)...(value.upperBound+diff)
                    convertedRanges[newRange] = newRange
                }
                
                processedRanges[range] = (processedRanges[range] ?? 0) + 1
            }
            
            index += 1
        }
        
        for outRange in outRanges.keys {
            if processedRanges[outRange] ?? 0 == 0 {
                convertedRanges[outRange] = outRange
            }
        }
    }
    
    var min: Int = Int.max
    for range in convertedRanges.keys.sorted(by: {$0.lowerBound > $1.lowerBound}) {
        if range.lowerBound < min {
            min = range.lowerBound
        }
    }
    
    return min
}

let first = firstProblem()
let second = secondProblem()

