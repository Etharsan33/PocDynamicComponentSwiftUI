//
//  Double++.swift
//  
//
//  Created by Elankumaran Tharsan on 04/05/2024.
//

import Foundation

public extension Double {
    
    var ratingDisplay: String {
        return String(format: "%.1f", locale: Locale.current, self)
    }
    
    var msToDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1000))
    }
}

// MARK: - Currency
public extension Double {
    
    func toCurrencyFormat(locale: Locale = Locale.current) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = locale
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        return currencyFormatter.string(from: NSNumber(value: self))
    }
    
    func toCurrencyFormatWithFallBack(locale: Locale = Locale.current) -> String {
        return self.toCurrencyFormat(locale: locale) ?? self.numberAfterComa(2)
    }
    
    func numberAfterComa(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = value
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

// MARK: - Unit
public extension Double {
    
    func toUnitKgOrT() -> String {
        let kg = Measurement<UnitMass>(value: self, unit: .kilograms)
        func getUnitMass() -> Measurement<UnitMass> {
            if kg.value >= 1000 {
                return kg.converted(to: .metricTons)
            }
            return kg
        }

        let unitMass = getUnitMass()
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = unitMass.value.tens >= 1 ? 0 : 1
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.roundingMode = .halfUp
        return formatter.string(from: unitMass)
    }
    
   private var tens: Int {
        if self <= 0 { return 0 }
        return Int(log10(self))
    }
    
    func toUnitKgOrTOnlyValue() -> Double {
        let stringValue = self.toUnitKgOrT().trimmingCharacters(in: .letters.union(.whitespaces))
        return NumberFormatter().number(from: stringValue)?.doubleValue ?? 0.0
    }
}
