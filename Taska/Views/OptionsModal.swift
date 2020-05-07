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

    
    var body: some View {
        VStack {
            Button(action: {
                self.partialSheetManager.closePartialSheet()
            }) {
                Text("Hide completed tasks")
            }
        }
    }
}

struct OptionsModal_Previews: PreviewProvider {
    static var previews: some View {
        OptionsModal()
    }
}
