//
//  Task.swift
//  Taska
//
//  Created by Andrew Nguyen on 4/30/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import Foundation


class Tasks: ObservableObject {
    var rewards: Rewards = Rewards()
    var tasks = [Task]()
    var completedTasks: [Task] = []
    @Published var percentageCompleted: Double = 0
    
    func addTask(task: Task) {
        tasks.append(task)
        print(tasks)
    }
    
    func transferTask(task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id}) {
            tasks.remove(at: index)
            completedTasks.insert(task, at: 0)
        } else {
            if let index = completedTasks.firstIndex(where: {$0.id == task.id}) {
                completedTasks.remove(at: index)
                tasks.insert(task, at: 0)
            }
        }
        calculatePercentageCompleted()
    }
    
    func calculatePercentageCompleted() {
        percentageCompleted = Double(completedTasks.count) / Double(tasks.count + completedTasks.count)
    }
}

class Task: Identifiable & ObservableObject {
    
    let id: UUID
    var title: Text
    var titleWithStrikethrough: Text
    var titleWithoutStrikethrough: Text
    
    var taskDone = false
    
    
    init() {
        id = UUID()
        title = Text("temp")
        titleWithoutStrikethrough = Text("temp")
        titleWithStrikethrough = Text("temp").strikethrough(color: .white)
    }
    
    func changeTitle(new_title: Text) {
        self.title = new_title
        titleWithoutStrikethrough = self.title
        titleWithStrikethrough = self.title.strikethrough(color: .white)
    }
    
    func toggleTaskDone() {
        self.taskDone.toggle()
        if self.taskDone {
            self.title = self.titleWithStrikethrough
        } else {
            self.title = self.titleWithoutStrikethrough
        }
        
    }
}

//struct Task_Previews: PreviewProvider {
//    var previews: some View {
//        Task()
//    }
//}
