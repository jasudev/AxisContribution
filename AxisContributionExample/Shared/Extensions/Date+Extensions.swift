//
//  Date+Extensions.swift
//  AxisContributionExample
//
//  Created by jasu on 2022/02/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

extension Date {
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    var dateHalfAyear: Date {
        var components = DateComponents()
        components.month = -6
        guard let date = Calendar.current.date(byAdding: components, to: startOfDay) else { return Date() }
        return date
    }

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
