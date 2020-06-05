//
//  NewTaskModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/1/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet
import UIKit

struct NewTaskModal: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    
    //@Binding var isPresented: Bool
//    var task: Task = Task()
//    @State var isTextFieldFirstResponder: Bool? = true
//    @State var isTempFirstResponder: Bool? = false
    @State var new_title: String = String("")
    @State var desiredHeight: CGFloat = 0
    @State var textColor: UIColor = UIColor.label
    var clearOnEdit: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                // Sets the task title after user inputs into text field
                //TextEditor(text: self.$new_title, task: self.task, desiredHeight: self.$desiredHeight, isFirstResponder: false, onCommit: {
                TextEditor(placeholderText: "Add task title", text: self.$new_title, textColor: self.$textColor, desiredHeight: self.$desiredHeight, isFirstResponder: false, clearOnEdit: self.clearOnEdit, onCommit: {
                    if self.new_title != "" {
                        self.tasks.addTask(task: Task())
                        self.tasks.tasks[0].changeTitle(new_title: self.new_title)
                        self.tasks.calculatePercentageCompleted()
                        self.new_title = ""
                    }
                    else {
                        self.partialSheetManager.closePartialSheet()
                    }
                })
                Spacer()
            }
        }
        .padding([.top, .bottom], 10)
        .frame(height: 120)
    }
}

//struct NewTaskModal_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskModal(isPresented: , task: Task())
//    }
//}

struct NewTaskModal_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskModal()
    }
}
