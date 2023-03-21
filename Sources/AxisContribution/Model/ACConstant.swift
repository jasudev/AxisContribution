//
//  ACConstant.swift
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

/// Defines the horizontal/vertical orientation of the contribution view.
public enum ACAxisMode: Equatable {
    /// Display the view horizontally.
    case horizontal
    /// Displays the view vertically.
    case vertical
}

public enum ACLevelLavel: Equatable {
    case moreOrLess
    case number
}

/// Settings that define the contribution view.
public struct ACConstant: Equatable {
    
    /// The start date to display the list of contributions.
    public var fromDate: Date
    
    /// The end date to display the list of contributions.
    public var toDate: Date
    
    /// The spacing in the row view showing the list of contributions.
    public var spacing: CGFloat
    
    /// A number that separates units between contribution levels.
    public var levelSpacing: Int
    
    /// The axis mode of the component.
    public var axisMode: ACAxisMode
    
    /// The font used for text.
    public var font: Font

    /// Whether the level label below the grid view is visible
    public var showLevelView: Bool
    
    public var levelLabel: ACLevelLavel
    
    /// Initializes `ACConstant`
    /// - Parameters:
    ///   - fromDate: The start date to display the list of contributions. The default value is `1 year from today.`.
    ///   - toDate: The end date to display the list of contributions. The default value is `today`.
    ///   - spacing: The spacing in the row view showing the list of contributions. The default value is `4`.
    ///   - levelSpacing: A number that separates units between contribution levels. The default value is `3`.
    ///   - axisMode: The axis mode of the component. The default value is `.horizontal`.
    ///   - font: The font used for text. The default value is `.system(size: 9)`.
    ///   - showLevelView: Whether the level label below the grid view is visible. The default value is `true`.
    public init(from fromDate: Date? = nil,
                to toDate: Date? = nil,
                spacing: CGFloat = 4,
                levelSpacing: Int = 3,
                axisMode: ACAxisMode = .horizontal,
                font: Font = .system(size: 9),
                showLevelView: Bool = true,
                levelLabel: ACLevelLavel = .moreOrLess) {
        self.fromDate = fromDate == nil ? Date().dateYearAgo : fromDate!
        self.toDate = toDate == nil ? Date() : toDate!
        self.spacing = spacing
        self.levelSpacing = levelSpacing
        self.axisMode = axisMode
        self.font = font
        self.showLevelView = showLevelView
        self.levelLabel = levelLabel
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.fromDate == rhs.fromDate &&
        lhs.toDate == rhs.toDate &&
        lhs.spacing == rhs.spacing &&
        lhs.levelSpacing == rhs.levelSpacing &&
        lhs.axisMode == rhs.axisMode &&
        lhs.font == rhs.font &&
        lhs.showLevelView == rhs.showLevelView
    }
}
