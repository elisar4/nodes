//  NodeView.swift
//  Created by Igor Manakov on 14.02.2024.

import SwiftUI

struct NodeView<Content: View>: View, Identifiable {
    @State var title: String
    
    @State private var isShowBody: Bool = true
    @State private var position = CGPoint.zero
    
    @ViewBuilder var content: (String) -> Content
    
    var id: String = UUID().uuidString
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                HeaderView(isShowBody: $isShowBody, title: title)
                    .transition(.scale)
                if isShowBody {
                    content(id)
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
                position = .init(x: proxy.size.width * CGFloat.random(in: 0.2...0.8),
                                 y: proxy.size.height * CGFloat.random(in: 0.2...0.8))
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
    var onLinkTap: (Binding<CGPoint>) -> Void?
    
    var body: some View {
        HStack {
            TextField("Hello", text: $text)
            LinkPointView(onTap: onLinkTap)
        }
        .padding(.leading, 8)
        .padding(.vertical, 8)
    }
}

struct TextDisplayNodeBodyView: View {
    @State var text: String
    var onLinkTap: (Binding<CGPoint>) -> Void?
    
    var body: some View {
        HStack {
            LinkPointView(onTap: onLinkTap)
            Spacer(minLength: 0)
            Text(text)
            Spacer(minLength: 0)
            LinkPointView(onTap: onLinkTap)
        }
        .padding(.vertical, 8)
    }
}

struct LinkPointView: View {
    @State private var point: CGPoint = .zero
    var onTap: (Binding<CGPoint>) -> Void?
    
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
        .onTapGesture {
            onTap($point)
        }
    }
}
