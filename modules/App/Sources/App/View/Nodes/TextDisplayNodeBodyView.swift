//  TextDisplayNodeBodyView.swift
//  Created by Vladimir Roganov on 21.02.2024

import SwiftUI
import Logic

class DisplayNode: ObservableObject {
    var model: Display
    
    @Published var text: String?
    
    init(model: Display) {
        self.model = model
        model.action = { [weak self] in
            self?.text = $0
        }
    }
}

struct TextDisplayNodeBodyView: View {
    @ObservedObject var displayModel: DisplayNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?
//    public var input: AnyPublisher<String?, Never> = CurrentValueSubject.init("").eraseToAnyPublisher()
//    public var output: PassthroughSubject<String?, Never> = .init()
    var body: some View {
        HStack {
            LinkPointView(onTap: {
                onLinkTap($0, .input(displayModel.model.input))
            })
            Spacer(minLength: 0)
            Text(displayModel.text ?? "nil")
            Spacer(minLength: 0)
            LinkPointView(onTap: {
                onLinkTap($0, .output(displayModel.model.output))
            })
        }
        .padding(.vertical, 8)
    }
}
