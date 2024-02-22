//
//  File.swift
//  
//
//  Created by Aiur Arkhipov on 22.02.2024.
//

import SwiftUI
import Logic

class RandomLetterNode: ObservableObject {
    var model: RandomLetter
    
    @Published var text: String?
    
    init(model: RandomLetter) {
        self.model = model
    }
}

struct RandomLetterNodeBodyView: View {
    @ObservedObject var model: RandomLetterNode
    var onLinkTap: (Binding<CGPoint>) -> Void?
    
    var body: some View {
        HStack {
//            LinkPointView(onTap: onLinkTap)
//            Spacer(minLength: 0)
            VStack {
//                Text(model.text ?? "nil")
                Button("Active random generation") {
                    model.model.run()
                }
            }
            Spacer(minLength: 0)
            LinkPointView(onTap: onLinkTap)
        }
        .padding(.vertical, 8)
    }
}
