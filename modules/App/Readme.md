# nodes logic concept

```swift

protocol Node {
    var input: [Node] { get }
    var output: [Node] { get }
    func process(input: String?)
}

class TextFieldNode: Node {
    var input: [Node] = []
    var output: [Node] = []

    func process(input: String?) {
        for node in output {
            node.process(input: input)
        }
    }
}

class TextDisplayNode: Node {
    var input: [Node] = []
    var output: [Node] = []

    func modify(input: String?) -> String? {
        // progress
        print(input)
        return input
    }

    func process(input: String?) {
        let result = modify(input: input)
        for node in output {
            node.process(input: result)
        }
    }
}

class TextCapitalizeNode: Node {
    var input: [Node] = []
    var output: [Node] = []

    func modify(input: String?) -> String? {
        return input?.capitalized
    }

    func process(input: String?) {
        let result = modify(input: input)
        for node in output {
            node.process(input: result)
        }
    }
}

func startProcessing() {
    let root = TextFieldNode()
    let n2 = TextCapitalizeNode()
    let n3 = TextDisplayNode()
    n2.output.append(n3)
    root.output.append(n2)
    root.process(input: "Test input")
}

```


///
/// TextFieldNode:
/// - give user ability to input some text
/// - 1 output -> String
///
/// TextDisplayNode:
/// - displays Label text
/// - take String input
/// - optional output String
///
