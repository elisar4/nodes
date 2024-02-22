import Combine

public protocol NodeInput {
    func linkInput(_ input: PassthroughSubject<String?, Never>, position: Int)
}

struct Logic {
    var running: Bool = true
}

public class RandomLetter {
    public var output: PassthroughSubject<String?, Never> = .init()

    public init() {}
    
    public func run() {
        let chars = "ABCDEFGHIJQKLMNOPRSTUVWXYZ".map({ $0 })
        output.send(chars[Int.random(in: 0...25)].description)
    }
}

class Join: NodeInput {

    public func linkInput(_ input: PassthroughSubject<String?, Never>, position: Int) {
        if position == 0 {
            linkParamOne(input)
        } else if position == 1 {
            linkParamOne(input)
        } else {

        }
    }

    var input1: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    var input2: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    var output: PassthroughSubject<String?, Never> = .init()

    private var listener: AnyCancellable?
    
    func linkParamOne(_ link: PassthroughSubject<String?, Never>) {
        input1 = link.eraseToAnyPublisher()
        subscribe()
    }
    
    func linkParamTwo(_ link: PassthroughSubject<String?, Never>) {
        input2 = link.eraseToAnyPublisher()
        subscribe()
    }
    
    private func subscribe() {
        listener = Publishers.CombineLatest(input1, input2)
            .sink { [weak output] (input1, input2) in
                output?.send((input1 ?? "") + (input2 ?? ""))
            }
    }
}

public class Display: NodeInput {
    public var input: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
    public var output: PassthroughSubject<String?, Never> = .init()
    
    private var listener: AnyCancellable?
    
    public init() {}


    public func linkInput(_ input: PassthroughSubject<String?, Never>, position: Int) {
        if position == 0 {
            linkInput(input)
        } else {

        }
    }

    public func linkInput(_ link: PassthroughSubject<String?, Never>) {
        input = link.eraseToAnyPublisher()
        listener = input
            .sink { [weak self] (input) in
                self?.output.send(input)
                self?.action?(input)
            }
    }
    
    public var action: ((_: String?) -> Void)? = {
        print($0 ?? "nil")
    }
}
