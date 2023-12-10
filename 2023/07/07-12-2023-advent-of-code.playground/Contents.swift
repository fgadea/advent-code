import Foundation

//MARK: Problem 1
let order: [Character: Int] = [
    "A":14,
    "K":13,
    "Q":12,
    "J":11,
    "T":10,
    "9": 9,
    "8": 8,
    "7": 7,
    "6": 6,
    "5": 5,
    "4": 4,
    "3": 3,
    "2": 2
]

enum CardType {
    case FiveOfKind
    case FourOfKind
    case FullHouse
    case ThreeOfKind
    case TwoPair
    case OnePair
    case HighCard
}

struct Card {
    let card: [Character: Int]
    var order: [Character]
    let bid: Int
}
func getCardType(card: [Character: Int]) -> CardType {
    if card.values.contains(5) {
        return .FiveOfKind
    }
    if card.values.contains(4) {
        return .FourOfKind
    }
    if card.values.contains(3) {
        if card.values.contains(2) {
            return .FullHouse
        }
        return .ThreeOfKind
    }
    let elements = card.values.filter({$0 == 2})
    if elements.count == 2 {
        return .TwoPair
    } else if elements.count == 1 {
        return .OnePair
    }
    return .HighCard
}

func getCardTypeWithJ(card: [Character: Int]) -> CardType {
    let jokers = card["J"] ?? 0
    if jokers == 0 {
        return getCardType(card: card)
    }
    
    var card = card
    card.removeValue(forKey: "J")
    switch jokers {
    case 4:
        return .FiveOfKind
    case 3:
        if card.values.contains(2) {
            return .FiveOfKind
        }
        return .FourOfKind
    case 2:
        if card.values.contains(3) {
            return .FiveOfKind
        }
        if card.values.contains(2) {
            return .FourOfKind
        }
        return .ThreeOfKind
    case 1:
        if card.values.contains(4) {
            return .FiveOfKind
        }
        if card.values.contains(3) {
            return .FourOfKind
        }
        let elements = card.values.filter({$0 == 2})
        if elements.count == 2 {
            return .FullHouse
        } else if elements.count == 1{
            return .ThreeOfKind
        }
        return .OnePair
    default:
        return .HighCard
    }
}



func firstProblem() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    var cards:[Card] = []
    for line in lines {
        let cardAndBid = line.split(separator: " ")
        var card: [Character: Int] = [:]
        var order: [Character] = []
        for char in cardAndBid[0] {
            if card[char] == nil {
                card[char] = 1
                order.append(char)
                continue
            }
            card[char]! += 1                
            order.append(char)

        }
        
        cards.append(Card(card: card, order: order, bid: Int(cardAndBid[1]) ?? 0))
    }
    
    var rankByType: [CardType] = []
    var cardsByType: [CardType: [Card]] = [:]
    for card in cards {
        let cardType = getCardType(card: card.card)
        var cardsOnType = cardsByType[cardType] ?? []
        cardsOnType.append(card)
        cardsByType[cardType] = cardsOnType
        if !rankByType.contains(cardType) {
            rankByType.append(cardType)
        } 
    }
    
    var result = 0
    var rankVal = 1
    for rank in [CardType.HighCard, CardType.OnePair, CardType.TwoPair, CardType.ThreeOfKind, CardType.FullHouse, CardType.FourOfKind, CardType.FiveOfKind] {
        var cardsOnType = cardsByType[rank] ?? []
        
//        print(cards)
        cardsOnType.sort(by: {
            var first = 0
            var maxChar1 = 0
            var mainKey1 = Character("z")
            var mainValue1 = 0
            var prev: Character = Character("z")
            for char in $0.order {
                if char == prev {
                    first += 1
                    continue
                }
                prev = char
                if first == 0 {
                    first += 1
                    continue
                }
                first *= 10
            }
            for entry in $0.card {
                let value = order[entry.key] ?? 0
                if value > maxChar1 {
                    maxChar1 = value
                }
                
                if entry.value > mainValue1 {
                    mainKey1 = entry.key
                    mainValue1 = entry.value
                }
            }
            var second = 0
            var maxChar2 = 0
            var mainKey2 = Character("z")
            var mainValue2 = 0
            prev = Character("z")
            for char in $1.order {
                if char == prev {
                    second += 1
                    continue
                }
                prev = char
                if first == 0 {
                    second += 1
                    continue
                }
                second *= 10
                second += 1
            }
            
            for entry in $1.card {
                let value = order[entry.key] ?? 0
                if value > maxChar2 {
                    maxChar2 = value
                }
                
                if entry.value > mainValue2 {
                    mainKey2 = entry.key
                    mainValue2 = entry.value
                }
            }
            
            if order[mainKey1] == maxChar1 && order[mainKey2] == maxChar2 {
                return first > second && maxChar1 > maxChar2
            }
            
            if order[mainKey1] != maxChar1 && order[mainKey2] == maxChar2 {
                return first > second && order[mainKey1] ?? 0 > maxChar2
            }
            
            if order[mainKey1] == maxChar1 && order[mainKey2] != maxChar2 {
                return first > second && maxChar1 > order[mainKey2] ?? 0
            }
            
            return first > second && order[mainKey1] ?? 0 > order[mainKey2] ?? 0
        })
        for card in cardsOnType {
            print(card)
            result += card.bid * rankVal 
            rankVal += 1
        }
    }
    return result
}

//MARK: Problem 2
func secondProblem() -> Int {let lines = ReadFile().read(file: "problem_01")
    var cards:[Card] = []
    for line in lines {
        let cardAndBid = line.split(separator: " ")
        var card: [Character: Int] = [:]
        var order: [Character] = []
        for char in cardAndBid[0] {
            if card[char] == nil {
                card[char] = 1
                order.append(char)
                continue
            }
            card[char]! += 1
            order.append(char)

        }
        
        cards.append(Card(card: card, order: order, bid: Int(cardAndBid[1]) ?? 0))
    }
    
    var rankByType: [CardType] = []
    var cardsByType: [CardType: [Card]] = [:]
    for card in cards {
        let cardType = getCardTypeWithJ(card: card.card)
        var cardsOnType = cardsByType[cardType] ?? []
        cardsOnType.append(card)
        cardsByType[cardType] = cardsOnType
        if !rankByType.contains(cardType) {
            rankByType.append(cardType)
        }
    }
    
    var result = 0
    var rankVal = 1
    for rank in [CardType.HighCard, CardType.OnePair, CardType.TwoPair, CardType.ThreeOfKind, CardType.FullHouse, CardType.FourOfKind, CardType.FiveOfKind] {
        var cardsOnType = cardsByType[rank] ?? []
        cardsOnType.sort(by: {
            var first = 0
            var prev: Character = Character("z")
            for char in $0.order {
                if char == prev {
                    first += 1
                    continue
                }
                prev = char
                if first == 0 {
                    first += 1
                    continue
                }
                first *= 10
            }
            var second = 0
            prev = Character("z")
            for char in $1.order {
                if char == prev {
                    second += 1
                    continue
                }
                prev = char
                if first == 0 {
                    second += 1
                    continue
                }
                second *= 10
                second += 1
            }
            
            return first > second
        })
        for card in cardsOnType {
            result += card.bid * rankVal
            rankVal += 1
        }
    }
    return result
    
}

let first = firstProblem()
//let second = secondProblem()
