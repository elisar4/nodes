
struct Logic {
    var running: Bool = true
}

class RandomLetter {
    func output() -> String {
        let chars = "ABCDEFGHIJQKLMNOPRSTUVWXYZ".map({ $0 })
        return chars[Int.random(in: 0...25)].description
    }
}
