//
//  ACDataStore.swift
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

/// A ViewModel that manages grid data.
public class ACDataStore: ObservableObject {
    
    @Published var constant: ACConstant = .init()
    @Published var datas: [[ACData]] = [[]]

    /// A method that creates data.
    /// - Parameters:
    ///   - constant: Settings that define the contribution view.
    ///   - externalDatas: Externally passed data. If data exists, external data takes precedence.
    func setup(constant: ACConstant, external externalDatas: [[ACData]]) {
        self.constant = constant
        self.datas = externalDatas
    }
    
    /// A method that creates data.
    /// - Parameters:
    ///   - constant: Settings that define the contribution view.
    ///   - sourceDates: An array of contributed dates.
    func setup(constant: ACConstant, source sourceDates: [Date: ACData]? = nil) {
        self.constant = constant
        if let sourceDates = sourceDates {
            self.datas = ACDataProvider.shared.mappedData(constant: constant, source: sourceDates)
        }
    }
}
