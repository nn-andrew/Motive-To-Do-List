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
    @ObservedObject var tasks: Tasks = Tasks()
    @ObservedObject var rewards: Rewards = Rewards()
    
    func body(content: Content) -> some View {
        content
            .environmentObject(Self.sheetManager)
            .environmentObject(self.tasks)
            .environmentObject(self.rewards)
    }
}
