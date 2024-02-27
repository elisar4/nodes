//  RandomLetterNodeView.swift
//  Created by Aiur Arkhipov on 22.02.2024.

import SwiftUI
import Logic

class RandomLetterNode: ObservableObject {
    var model: RandomLetter
    
    init(model: RandomLetter) {
        self.model = model
    }
}

struct RandomLetterNodeBodyView: View {
    @ObservedObject var model: RandomLetterNode
    var onLinkTap: (Binding<CGPoint>, NodeParam) -> Void?

    var body: some View {
        HStack {
            VStack {
                Button("Active random generation") {
                    model.model.run()
                }
            }
            Spacer(minLength: 0)
            LinkPointView(onTap: {
                onLinkTap($0, .output(model.model.output))
            })
        }
        .padding(.vertical, 8)
    }
}
