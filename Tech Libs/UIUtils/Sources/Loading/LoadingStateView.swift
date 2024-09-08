//
//  LoadingStateView.swift
//
//
//  Created by Elankumaran Tharsan on 26/12/2023.
//

import SwiftUI

struct LoadingStateView: View {
    var data: LoadingStateData
    
    var body: some View {
        VStack(alignment: .center, spacing: .ds.s, content: {
            data.image
            data.title.map(Text.init)
            Text(data.message)
            data.ctaType.map { type in
                switch type {
                case .retry(let string, let action):
                    Button(string, action: action)
                case .custom(let string, let action):
                    Button(string, action: action)
                }
            }
        })
        .multilineTextAlignment(.center)
        .padding(.init(top: .ds.m, leading: .ds.m, bottom: .ds.m, trailing: .ds.m))
    }
}

#Preview {
    LoadingStateView(data: .init(image: Image(systemName: "clock"), title: "Le title d'un texte", message: "un message qui décrit le contenu de l'erreur en question", ctaType: .retry("Veillez réessayer") {
        
    }))
}
