//  NodeView.swift
//  Created by Igor Manakov on 14.02.2024.

import SwiftUI

struct NodeView<Content: View>: View {
    @State var title: String
    
    @State private var isShowBody: Bool = true
    @State private var position = CGPoint.zero
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                HeaderView(isShowBody: $isShowBody, title: title)
                    .transition(.scale)
                if isShowBody {
                    content()
                }
            }
            .frame(minWidth: 0, idealWidth: 200, minHeight: 0)
            .fixedSize()
            .background(.background)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            .position(position)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        position = gesture.location
                    }
            )
            .onAppear {
                position = .init(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
        }
    }
}

struct HeaderView: View {
    @Binding var isShowBody: Bool
    @State var title: String
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    isShowBody.toggle()
                }
            } label: {
                if isShowBody {
                    Image(systemName: "chevron.down")
                } else {
                    Image(systemName: "chevron.right")
                }
            }
            .frame(width: 20, height: 20)
            .fixedSize()
            Text(title)
            
            Spacer()
        }
        .padding()
        .background(.bar)
    }
}

struct TextFieldNodeBodyView: View {
    @State var text: String = ""
    @Binding var outputPoint: CGPoint
    
    var body: some View {
        HStack {
            TextField("Hello", text: $text)
            LinkPointView(point: $outputPoint)
        }
        .padding(.leading, 8)
        .padding(.vertical, 8)
    }
}

struct TextDisplayNodeBodyView: View {
    @State var text: String
    @Binding var inputPoint: CGPoint
    @Binding var outputPoint: CGPoint
    
    var body: some View {
        HStack {
            LinkPointView(point: $inputPoint)
            Spacer(minLength: 0)
            Text(text)
            Spacer(minLength: 0)
            LinkPointView(point: $outputPoint)
        }
        .padding(.vertical, 8)
    }
}

struct LinkPointView: View {
    @Binding var point: CGPoint
    
    var body: some View {
        GeometryReader { geo in
            Image(systemName: "circle.circle")
                .onChange(of: geo.frame(in: .global)) { _ in
                    point = .init(x: geo.frame(in: .global).midX,
                                  y: geo.frame(in: .global).midY)
                }
        }
        .frame(width: 20, height: 20)
        .fixedSize()
    }
}
