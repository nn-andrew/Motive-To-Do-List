//
//  NewTaskModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/1/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet

struct NewTaskModal: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    
    //@Binding var isPresented: Bool
    var task: Task = Task()
    @State var isTextFieldFirstResponder: Bool? = true
    @State var isTempFirstResponder: Bool? = false
    @State var new_title: String = String("")
    
    var body: some View {
        GeometryReader { geo in
            // Sets the task title after user inputs into text field
            TextField("Add task title", text: self.$new_title, onCommit: {
                self.task.changeTitle(new_title: Text(self.new_title))
                self.tasks.addTask(task: self.task)
                self.tasks.calculatePercentageCompleted()
                self.partialSheetManager.closePartialSheet()
            })
        }
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
