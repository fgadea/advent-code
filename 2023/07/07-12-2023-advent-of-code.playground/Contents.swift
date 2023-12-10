import Foundation

//MARK: Problems 1 & 2
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
    let card: String
    var characters: [Character]
    let bid: Int
}
func getCardType(card: String) -> CardType {
    var dict: [Character: Int] = [:]
    for char in card {
        if dict[char] == nil {
            dict[char] = 1
            continue
        }
        dict[char]! += 1
    }
    if dict.values.contains(5) {
        return .FiveOfKind
    }
    if dict.values.contains(4) {
        return .FourOfKind
    }
    if dict.values.contains(3) {
        if dict.values.contains(2) {
            return .FullHouse
        }
        return .ThreeOfKind
    }
    let elements = dict.values.filter({$0 == 2})
    if elements.count == 2 {
        return .TwoPair
    } else if elements.count == 1 {
        return .OnePair
    }
    return .HighCard
}

func getCardTypeWithJ(card: String) -> CardType {
    var dict: [Character: Int] = [:]
    for char in card {
        if dict[char] == nil {
            dict[char] = 1
            continue
        }
        dict[char]! += 1
    }
    
    let jokers = dict[Character("1")] ?? 0
    if jokers == 0 {
        return getCardType(card: card)
    }
    
    dict.removeValue(forKey: "1")
    switch jokers {
    case 5, 4:
        return .FiveOfKind
    case 3:
        if dict.values.contains(2) {
            return .FiveOfKind
        }
        return .FourOfKind
    case 2:
        if dict.values.contains(3) {
            return .FiveOfKind
        }
        if dict.values.contains(2) {
            return .FourOfKind
        }
        return .ThreeOfKind
    case 1:
        if dict.values.contains(4) {
            return .FiveOfKind
        }
        if dict.values.contains(3) {
            return .FourOfKind
        }
        let elements = dict.values.filter({$0 == 2})
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



func problem(withJokers: Bool = false) -> Int {
    let lines = ReadFile().read(file: "problem_01")
    var cards:[Card] = []
    for line in lines {
        let cardAndBid = line.split(separator: " ")
        var card: String = String(cardAndBid[0])
        
        card.replace("A", with: "?")
        card.replace("K", with: ">")
        card.replace("Q", with: "=")
        card.replace("J", with: withJokers ? "1" : "<")
        card.replace("T", with: ";")
        
        var characters: [Character] = Array(card)
        
        cards.append(Card(card: card, characters: characters, bid: Int(cardAndBid[1]) ?? 0))
    }
    
    var rankByType: [CardType] = []
    var cardsByType: [CardType: [Card]] = [:]
    for card in cards {
        let cardType = withJokers ? getCardTypeWithJ(card: card.card) : getCardType(card: card.card)
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
        cardsOnType = cardsOnType.sorted(by: {$0.card < $1.card })
        
        for card in cardsOnType {
            result += card.bid * rankVal
            rankVal += 1
        }
    }
    return result
}

let first = problem()
let second = problem(withJokers: true)
