//
//  GlucoseFormatter.swift
//  Loop
//
//  Created by Pete Schwamb on 1/8/17.
//  Copyright © 2017 LoopKit Authors. All rights reserved.
//

import Foundation
import HealthKit

class GlucoseFormatter {
    private let unit: HKUnit
    private let numberFormatter: NumberFormatter

    init(_ unit: HKUnit) {
        self.unit = unit

        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = unit.preferredFractionDigits
        numberFormatter.maximumFractionDigits = unit.preferredFractionDigits
    }

    func string(_ value: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: value)) ?? "-"
    }

    func stringWithUnit(_ value: Double) -> String {
        let stringValue = string(value)
        return String(
            format: NSLocalizedString("GLUCOSE_VALUE_AND_UNIT",
                                      value: "%1$@ %2$@",
                                      comment: "Format string for localized glucose value and unit"
            ),
            stringValue,
            unit.glucoseUnitDisplayString
        )
    }

    func describing(_ quantity: HKQuantity) -> String {
        return describing(quantity.doubleValue(for: unit))
    }

}
