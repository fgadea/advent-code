import Foundation

//MARK: Problem 1
func problem1() -> Int {
    let dataAndPatterns: [(data: String, pattern: String)] = ReadFile().read(file: "problem_01").compactMap({
        let splited = $0.split(separator: " ")
        return (String(splited[0]), String(splited[1]))
    })
    
    for dataAndPattern in dataAndPatterns {
        let data = dataAndPattern.data
        let pattern = dataAndPattern.pattern.split(separator: ",")
        for number in pattern {
            var count = 0
            let strings = data.split(separator: ".")
            for string in strings {
                if string.count == Int(number) {
                    break
                }
            }
        }
    }
    
    return 0
}

//MARK: Problem 2
func problem2() -> Int {
    return 0
}

let first = problem1()
//print(first)
//let second = problem2()
