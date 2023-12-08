import Foundation

//MARK: Problem 1
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
    let bid: Int
}
func getCardType(card: String) -> CardType {
    var chars: [Character: Int] = [:]
    for char in card {
        chars[char] = (chars[char] ?? 0) + 1
    }
    if chars.values.contains(card.count) {
        return .FiveOfKind
    }
    if chars.values.contains(card.count - 1) {
        return .FourOfKind
    }
    if chars.values.contains(card.count - 2) {
        if chars.values.contains(card.count - 3) {
            return .FullHouse
        } 
        return .ThreeOfKind
    }
    let elements = chars.values.filter({$0 == 2})
    if elements.count == 2 {
        return .TwoPair
    } else if elements.count == 1{
        return .OnePair
    }
    return .HighCard
}
func firstProblem() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    var cards:[Card] = []
    for line in lines {
        let cardAndBid = line.split(separator: " ")
        cards.append(Card(card: String(cardAndBid[0]), bid: Int(cardAndBid[1]) ?? 0))
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
        cardsOnType.sort(by: {$0.card > $1.card})
        for card in cardsOnType {
            print(card)
            result += card.bid * rankVal 
            rankVal += 1
        }
    }
    return result
}

//MARK: Problem 2
func secondProblem() -> Int {
    let lines = ReadFile().read(file: "problem_01")
    
    return 0
}

let first = firstProblem()
let second = secondProblem()
