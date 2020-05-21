//
//  SystemServices.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/4/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import Foundation
import PartialSheet

struct SystemServices: ViewModifier {
    
    static var sheetManager: PartialSheetManager = PartialSheetManager()
    @ObservedObject static var tasks: Tasks = Tasks()
    @ObservedObject static var rewards: Rewards = Rewards()
    
    func body(content: Content) -> some View {
        content
            .environmentObject(Self.sheetManager)
            .environmentObject(Self.tasks)
            .environmentObject(Self.rewards)
    }
}
