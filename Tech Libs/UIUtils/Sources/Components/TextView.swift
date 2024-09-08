//
//  TextView.swift
//
//
//  Created by Elankumaran Tharsan on 12/05/2024.
//

import SwiftUI

public struct TextView: View {
    private let placeholder: String
    @Binding var text: String
    
    public init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text(placeholder)
                        .padding(.top, .ds.m)
                        .padding(.leading, .ds.m - 2)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $text)
                    .opacity(text.isEmpty ? 0.7 : 1)
                Spacer()
            }
        }
        .color(.ds.textPrimary)
        .font(.ds.body())
        .padding(.all, .ds.m)
        .cornerRadiusWithBorder(radius: .ds.s, width: 1, color: .ds.gray.opacity(0.2))
        .background(Color.white)
    }
}

public struct TextWithTextLimitView: View {
    private let placeholder: String
    @Binding var text: String
    @State var characterLimit: Int
    
    @State private var typedCharacters: Int = 0
    
    public init(_ placeholder: String, characterLimit: Int, text: Binding<String>) {
        self.placeholder = placeholder
        self.characterLimit = characterLimit
        self._text = text
    }
    
    public var body: some View {
        VStack {
            TextView(placeholder, text: $text)
                .limitText($text, to: characterLimit, onTextChange: {
                    typedCharacters = text.count
                })
            HStack {
                Spacer()
                Text("\(typedCharacters) / \(characterLimit)")
                    .color(.ds.grayLight)
                    .font(.ds.smallBody())
            }
        }
    }
}

public extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int, onTextChange: (() -> Void)? = nil) -> some View {
        self.onChange(of: text.wrappedValue) { _ in
            onTextChange?()
            text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
        }
    }
}
