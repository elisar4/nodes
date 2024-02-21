
struct Logic {
    var running: Bool = true
}

class RandomLetter {
    func output() -> String {
        let chars = "ABCDEFGHIJQKLMNOPRSTUVWXYZ".map({ $0 })
        return chars[Int.random(in: 0...25)].description
    }
}

class Join {
    var firstParam: String?
    var lastParam: String?
    
    func input(firstParam: String?, lastParam: String?) {
        self.firstParam = firstParam
        self.lastParam = lastParam
    }
    
    func output() -> String? {
        return (firstParam ?? "") + (lastParam ?? "")
    }
}
