//
//  ACData.swift
//  AxisContribution
//
//  Created by jasu on 2022/02/23.
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

/// The model that defines the row view.
public class ACData: Equatable {
    
    /// Current date.
    var date: Date
    
    /// The number contributed to the current date.
    var count: Int
    
    /// Initializes `ACData`
    /// - Parameters:
    ///   - date: Current date.
    ///   - count: The number contributed to the current date. The default value is `0`.
    init(date: Date, count: Int = 0) {
        self.date = date
        self.count = count
    }
    
    public static func == (lhs: ACData, rhs: ACData) -> Bool {
        lhs.date == rhs.date && lhs.count == lhs.count
    }
}
