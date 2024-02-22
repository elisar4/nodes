import Combine

struct Logic {
    var running: Bool = true
}

class RandomLetter {
    var output: PassthroughSubject<String, Never> = .init()
    
    func run() {
        let chars = "ABCDEFGHIJQKLMNOPRSTUVWXYZ".map({ $0 })
        output.send(chars[Int.random(in: 0...25)].description)
    }
}

class Join {
    private var firstParam: String?
    private var lastParam: String?
    
    func input(firstParam: String?, lastParam: String?) {
        self.firstParam = firstParam
        self.lastParam = lastParam
    }
    
    func output() -> String? {
        return (firstParam ?? "") + (lastParam ?? "")
    }
}

class Display {
    private var inputParam: String?
    var action: ((_: String?) -> Void)? = {
        print($0)
    }
    
    func input(_ param: String?) {
        self.inputParam = param
        action?(param)
    }
    
    func output() -> String? {
        return inputParam
    }
}
