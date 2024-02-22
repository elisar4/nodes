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
    var input1: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    var input2: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    var output: PassthroughSubject<String, Never> = .init()
    
    private var listener: AnyCancellable?
    
    func linkParamOne(_ link: PassthroughSubject<String, Never>) {
        input1 = link.map(Optional.init).eraseToAnyPublisher()
        subscribe()
    }
    
    func linkParamTwo(_ link: PassthroughSubject<String, Never>) {
        input2 = link.map(Optional.init).eraseToAnyPublisher()
        subscribe()
    }
    
    private func subscribe() {
        listener = Publishers.CombineLatest(input1, input2)
            .sink { [weak output] (input1, input2) in
                output?.send((input1 ?? "") + (input2 ?? ""))
            }
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
