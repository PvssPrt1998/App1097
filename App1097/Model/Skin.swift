import Foundation

struct Skin: Hashable {
    let uuid: UUID
    let image: Data
    let name: String
    var quantity: Int
    let quality: Int
}

struct Case: Hashable {
    let uuid: UUID
    let image: Data
    let name: String
    var quantity: Int
}

struct Term: Hashable {
    let uuid: UUID
    var image: Data
    var name: String
    var favourite: Bool
    var learned: Bool
}

struct Portfolio {
    var covert: Int
    var classified: Int
    var restricted: Int
    var milspec: Int
    var industrialGrade: Int
    var consumerGrade: Int
}
