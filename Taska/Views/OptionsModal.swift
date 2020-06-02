//
//  OptionsModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/5/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet

struct OptionsModal: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Button(action: {
                    self.tasks.removeAllCompletedTasks()
    //                self.partialSheetManager.closePartialSheet()
                }) {
                    HStack {
                        Text("Remove all completed tasks")
                        Spacer()
                    }
                }
            }
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 30)
        .frame(height: 100)
    }
}

struct OptionsModal_Previews: PreviewProvider {
    static var previews: some View {
        OptionsModal()
    }
}
