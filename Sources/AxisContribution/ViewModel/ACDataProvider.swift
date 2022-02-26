//
//  ACDataProvider.swift
//  AxisContribution
//
//  Created by jasu on 2022/02/26.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftUI

/// Create and provide data.
public class ACDataProvider {
    
    public static let shared = ACDataProvider()
    
    /// Generate data from start date to end date.
    /// - Parameters:
    ///   - constant: Settings that define the contribution view.
    ///   - sourceDates: An array of contributed dates.
    /// - Returns: mapped data
    public func mappedData(constant: ACConstant, source sourceDates: [Date]) -> [[ACData]] {
        var newDatas = [[ACData]]()
        var dateWeekly = Date.datesWeekly(from: constant.fromDate, to: constant.toDate)
        if constant.axisMode == .vertical {
            dateWeekly = dateWeekly.reversed()
        }
        dateWeekly.forEach { date in
            let datas = date.datesInWeek.map { date -> ACData in
                let data = ACData(date: date, count: getDateCount(sourceDates: sourceDates, date: date))
                return data
            }
            newDatas.append(datas)
        }
        return newDatas
    }

    /// Returns data corresponding to the date you pass in.
    /// - Parameters:
    ///   - sourceDates: An array of contributed dates.
    ///   - date: The date required to return the data.
    /// - Returns: -
    private func getDateCount(sourceDates: [Date], date: Date) -> Int {
        let dates = sourceDates.filter { d in
            Calendar.current.isDate(d, inSameDayAs: date)
        }
        return dates.count
    }
}
