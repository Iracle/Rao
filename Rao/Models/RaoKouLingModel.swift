//
//  RaoKouLingModel.swift
//  Rao
//
//  Created by Iracle Zhang on 6/19/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import Foundation

public struct RaoKouLingInfo {
    
    let groupPriority: String!
    let title: String!
    let content: String!
    
    init(groupPriority: String!, title: String!, content: String!) {
        self.groupPriority = groupPriority
        self.title = title
        self.content = content
    }
}

extension RaoKouLingInfo: Equatable {}

public func == (lhs: RaoKouLingInfo, rhs: RaoKouLingInfo) -> Bool {
    let areEqual = lhs.groupPriority == rhs.groupPriority &&
        lhs.title == rhs.title && lhs.content == rhs.content
    
    return areEqual
}

public struct RaoRankInfo {
    let groupPriority: String!
    let rankDescription: String!
    
}









