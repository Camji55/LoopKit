//
//  ChartAxisValueDoubleUnit.swift
//  LoopKitUI
//
//  Created by Nate Racklyeft on 7/16/16.
//  Copyright © 2016 Nathan Racklyeft. All rights reserved.
//

import Foundation
import LoopKit


/// A formatted value plotted on a chart.
///
/// `scalar` is the value in plot space (for most charts this is the actual value; the dose
/// chart plots values in a signed-log space), and `label` is the localized display text
/// shown when the point is highlighted (e.g. "115 mg/dL").
public struct ChartValue: Equatable, CustomStringConvertible {
    public let scalar: Double
    public let label: String

    public init(scalar: Double, label: String) {
        self.scalar = scalar
        self.label = label
    }

    public init(scalar: Double, unitString: String? = nil, formatter: NumberFormatter) {
        self.init(scalar: scalar, actual: scalar, unitString: unitString, formatter: formatter)
    }

    public init(scalar: Double, actual: Double, unitString: String? = nil, formatter: NumberFormatter) {
        self.scalar = scalar

        if let unitString = unitString {
            self.label = formatter.string(from: actual, unit: unitString) ?? ""
        } else {
            self.label = formatter.string(from: NSNumber(value: actual)) ?? ""
        }
    }

    public var description: String {
        return label
    }
}


/// A single date-stamped point charted by one of the Loop charts.
public struct ChartPoint: Equatable {
    /// The date of the value, or nil for points that only participate in axis scaling.
    public let date: Date?

    public let y: ChartValue

    public init(date: Date?, y: ChartValue) {
        self.date = date
        self.y = y
    }

    public init(date: Date?, value: Double) {
        self.init(date: date, y: ChartValue(scalar: value, label: ""))
    }
}


extension ChartPoint: TimelineValue {
    public var startDate: Date {
        return date ?? Date.distantPast
    }
}
