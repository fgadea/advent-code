import Foundation

enum Almanacs: String {
    case none
    case seedToSoil = "seed-to-soil map:"
    case soilToDertilizer = "soil-to-fertilizer map:"
    case fertilizerToWater = "fertilizer-to-water map:"
    case waterToLight = "water-to-light map:"
    case lightToTemperature = "light-to-temperature map:"
    case temperatureToHumidity = "temperature-to-humidity map:"
    case humidityToLocation = "humidity-to-location map:"
}

//MARK: Problem 1
func firstProblem() {
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
        case .soilToDertilizer:
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
    
    print(lowestLocation)
}

//MARK: Problem 2
// !!!!!!Exponencial solution. Not practical. Must be improved and optimised!!!!!!
func secondProblem() {
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
            let rangeSeeds = rawSeed.split(separator: " ").compactMap({Int($0)})
            
            for i in stride(from: 0, to: rangeSeeds.count, by: 2) {
                for val in rangeSeeds[i]..<(rangeSeeds[i] + rangeSeeds[i+1]) {
                    seeds.append(val)
                }
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
        case .soilToDertilizer:
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
    
    print(lowestLocation)
}

firstProblem()
secondProblem()

