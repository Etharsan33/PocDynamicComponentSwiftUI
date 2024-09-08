//
//  DS+Checkbox.swift
//
//
//  Created by Elankumaran Tharsan on 09/05/2024.
//

import SwiftUI

@available(iOS 15.0, *)
public extension ToggleStyle where Self == CheckboxToggleStyle {
    static var dsCheckmark: CheckboxToggleStyle { CheckboxToggleStyle(config: .init(type: .check, unSelectedBorderColor: .ds.gray20, selectedFillColor: .ds.primary)) }
    static var dsRadio: CheckboxToggleStyle { CheckboxToggleStyle(config: .init(type: .radio, unSelectedBorderColor: .ds.gray20, selectedFillColor: .ds.primary)) }
}

@available(iOS 15.0, *)
public struct CheckboxToggleStyle: ToggleStyle {
    
    struct CheckboxToggleConfig {
        enum ToggleType {
            case check, radio
        }
        let type: ToggleType
        let unSelectedBorderColor: Color
        let selectedFillColor: Color
    }
    
    let config: CheckboxToggleConfig
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .ds.l) {
            self.shape(isOn: configuration.isOn)
                .frame(width: 24, height: 24)
            configuration.label
            Spacer()
        }.onTapGesture {
            withAnimation(.spring()) {
                configuration.isOn.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func shape(isOn: Bool) -> some View {
        switch config.type {
        case .check:
            check(isOn)
        case .radio:
            radio(isOn)
        }
    }
    
    private func check(_ isOn: Bool) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(isOn ? .clear : config.unSelectedBorderColor, lineWidth: 2)
            .applyIf(isOn, apply: { view in
                view.background(config.selectedFillColor)
            })
            .cornerRadius(4)
            .applyIf(isOn, apply: { view in
                view.overlay {
                    Image("ic_check", bundle: .module)
                }
            })
    }
    
    private func radio(_ isOn: Bool) -> some View {
        Circle()
            .stroke(isOn ? .clear : config.unSelectedBorderColor, lineWidth: 2)
            .applyIf(isOn, apply: { view in
                view.background(Circle().foregroundColor(config.selectedFillColor))
            })
            .applyIf(isOn, apply: { view in
                view.overlay {
                    Circle().frame(width: 12, height: 12).color(.white)
                }
            })
    }
}

