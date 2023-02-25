//
//  AxisContribution.swift
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

/// Defines the unit of contribution level.
enum ACLevel: Int, CaseIterable {
    case zero = 0, first, second, third, fourth
    
    /// Opacity value according to level.
    var opacity: CGFloat {
        switch self {
        case .zero:     return 0
        case .first:    return 0.3
        case .second:   return 0.5
        case .third:    return 0.7
        case .fourth:   return 0.9
        }
    }
}

public struct AxisContribution<B, F>: View where B: View, F: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var store = ACDataStore()
    
    private var constant: ACConstant = .init()
    private var sourceDatas: [Date]? = nil
    private var externalDatas: [[ACData]]? = nil
    
    public var background: ((ACIndexSet?, ACData?) -> B)? = nil
    public var foreground: ((ACIndexSet?, ACData?) -> F)? = nil
    
    private var defaultRowSize: CGFloat = 11
    @Namespace private var trailing
    
    public var body: some View {
        ScrollViewReader { proxy in
            VStack(alignment: .trailing, spacing: constant.spacing * 1.6) {
                ScrollView(constant.axisMode == .horizontal ? .horizontal : .vertical, showsIndicators: false) {
                    if constant.axisMode == .horizontal {
                        HStack(spacing: 0) {
                            content
                            Spacer()
                                .frame(width: 0, height: 0)
                                .id(trailing)
                                .onAppear {
                                    proxy.scrollTo(trailing, anchor: .trailing)
                                }
                        }
                        .contentShape(Rectangle())
                    }else {
                        VStack(spacing: 0) {
                            content
                        }
                        .contentShape(Rectangle())
                    }
                }
                levelView
            }
        }
        .environmentObject(store)
        .onChange(of: sourceDatas) { newValue in
            store.setup(constant: self.constant, source: newValue)
        }
        .onAppear(perform: {
            self.fetch()
        })
    }
    
    //MARK: - Properties
    
    /// A content view that displays a grid view.
    private var content: some View {
        ACGridStack(constant: constant) { indexSet, data in
            getBackgroundView(indexSet, data)
        } foreground: { indexSet, data in
            getForegroundView(indexSet, data)
        }
    }
    
    /// The background view of the default row view.
    private var defaultBackground: some View {
        Rectangle()
            .fill(Color(hex: colorScheme == .dark ? 0x171B21 : 0xF0F0F0))
            .frame(width: defaultRowSize, height: defaultRowSize)
            .cornerRadius(2)
    }
    
    /// The foreground view of the default row view.
    private var defaultForeground: some View {
        Rectangle()
            .fill(Color(hex: 0x6CD164))
            .frame(width: defaultRowSize, height: defaultRowSize)
            .border(Color.white.opacity(0.2), width: 1)
            .cornerRadius(2)
    }
    
    /// A view that displays level unit information.
    @ViewBuilder
    private var levelView: some View {
        if constant.showLevelView {
            HStack(spacing: constant.spacing * 0.5) {
                Text("Less")
                    .font(constant.font)
                    .opacity(0.6)
                HStack(spacing: 0) {
                    ForEach(ACLevel.allCases, id:\.self) { level in
                        ZStack {
                            getBackgroundView(nil, nil)
                            getForegroundView(nil, nil)
                                .opacity(level.opacity)
                        }
                    }.scaleEffect(0.82)
                }
                Text("More")
                    .font(constant.font)
                    .opacity(0.6)
            }
        }
    }
    
    //MARK: - Methods
    
    /// The background view of the row view.
    /// - Parameters:
    ///   - indexSet: The location index information of the row view displayed in the grid.
    ///   - data: The model that defines the row view.
    /// - Returns: -
    private func getBackgroundView(_ indexSet: ACIndexSet? = nil, _ data: ACData? = nil) -> some View {
        Group {
            if let background = background {
                background(indexSet, data)
            }else {
                defaultBackground
            }
        }
    }
    
    /// The foreground view of the row view.
    /// - Parameters:
    ///   - indexSet: The location index information of the row view displayed in the grid.
    ///   - data: The model that defines the row view.
    /// - Returns: -
    private func getForegroundView(_ indexSet: ACIndexSet? = nil, _ data: ACData? = nil) -> some View {
        Group {
            if let foreground = foreground {
                foreground(indexSet, data)
            }else {
                defaultForeground
            }
        }
    }
    
    /// Fetch data.
    private func fetch() {
        if let externalDatas = externalDatas {
            store.setup(constant: self.constant, external: externalDatas)
        }else {
            store.setup(constant: self.constant, source: self.sourceDatas)
        }
    }
}

public extension AxisContribution where B == EmptyView, F == EmptyView {

    /// Initializes `AxisContribution`
    /// - Parameters:
    ///   - constant: Settings that define the contribution view.
    ///   - sourceDates: An array of contributed dates.
    init(constant: ACConstant = .init(), source sourceDates: [Date] = []) {
        self.constant = constant
        self.sourceDatas = sourceDates
    }
    
    /// Initializes `AxisContribution`
    /// - Parameters:
    ///   - constant: Settings that define the contribution view.
    ///   - externalDatas: Externally passed data. If data exists, external data takes precedence.
    init(constant: ACConstant = .init(), external externalDatas: [[ACData]]? = nil) {
        self.constant = constant
        self.externalDatas = externalDatas
    }
}

public extension AxisContribution where B : View, F : View {
    
    /// Initializes `AxisContribution`
    /// - Parameters:
    ///   - constant: Settings that define the contribution view.
    ///   - sourceDates: An array of contributed dates.
    ///   - background: The view that is the background of the row view.
    ///   - foreground: The view that is the foreground of the row view.
    init(constant: ACConstant = .init(),
         source sourceDates: [Date] = [],
         @ViewBuilder background: @escaping (ACIndexSet?, ACData?) -> B,
         @ViewBuilder foreground: @escaping (ACIndexSet?, ACData?) -> F) {
        self.constant = constant
        self.sourceDatas = sourceDates
        self.background = background
        self.foreground = foreground
    }
    
    /// Initializes `AxisContribution`
    /// - Parameters:
    ///   - constant: Settings that define the contribution view.
    ///   - background: The view that is the background of the row view.
    ///   - foreground: The view that is the foreground of the row view.
    ///   - externalDatas: Externally passed data. If data exists, external data takes precedence.
    init(constant: ACConstant = .init(), external externalDatas: [[ACData]]? = nil,
         @ViewBuilder background: @escaping (ACIndexSet?, ACData?) -> B,
         @ViewBuilder foreground: @escaping (ACIndexSet?, ACData?) -> F) {
        self.constant = constant
        self.background = background
        self.foreground = foreground
        self.externalDatas = externalDatas
    }
}

struct AxisContribution_Previews: PreviewProvider {
    static var previews: some View {
        AxisContribution(constant: .init(), source: [])
    }
}
