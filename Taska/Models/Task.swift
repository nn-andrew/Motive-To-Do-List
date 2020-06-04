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
//    var tasks = [Task(), Task(), Task(), Task()]
    var tasks = [Task]()
    var completedTasks: [Task] = []
    var totalTasksCount: Int = 0
    var totalCompletedTasksCount: Int = 0
    var completedTasksForNextReward: Int = 0
    @Published var percentageCompleted: Double = 0
    @Published var animated = true
    
    func addTask(task: Task) {
        tasks.insert(task, at: 0)
//        for task in completedTasks {
//            task.reentryIndex += 1
//        }
        task.reentryIndex = totalTasksCount
        totalTasksCount += 1
        print(tasks)
    }
    
    func removeAllCompletedTasks() {
        completedTasks.removeAll()
        totalTasksCount = tasks.count
        calculatePercentageCompleted()
    }
    
    func removeTask(task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id}) {
            tasks.remove(at: index)
//            for task in completedTasks {
//                if index < task.reentryIndex {
//                    task.reentryIndex -= 1
//                }
//            }
        } else {
            if let index = completedTasks.firstIndex(where: {$0.id == task.id}) {
                completedTasks.remove(at: index)
            }
        }

        for t in tasks {
            if t.reentryIndex > task.reentryIndex {
                t.reentryIndex -= 1
            }
        }
        for t in completedTasks {
            if t.reentryIndex > task.reentryIndex {
                t.reentryIndex -= 1
            }
        }
        totalTasksCount -= 1
        
        calculatePercentageCompleted()
        
    }
    
    func transferTask(task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id}) {
//            if task.reentryIndex == -1 {
//                task.reentryIndex = firstUnusedReentryIndex(index: index)
//            }
            tasks.remove(at: index)
            completedTasks.insert(task, at: 0)
        } else {
            if let index = completedTasks.firstIndex(where: {$0.id == task.id}) {
                completedTasks.remove(at: index)
//                tasks.insert(task, at: task.reentryIndex < tasks.count ? task.reentryIndex : tasks.count)
                tasks.insert(task, at: 0)
                tasks.sort(by: { $0.reentryIndex > $1.reentryIndex })
            }
        }
        calculatePercentageCompleted()
    }
    
//    func firstUnusedReentryIndex(index: Int) -> Int {
//        for task in completedTasks {
//            if index == task.reentryIndex {
//                return firstUnusedReentryIndex(index: index + 1)
//            }
//        }
//        return index
//    }
    
    func calculatePercentageCompleted() {
        if tasks.count + completedTasks.count > 0 {
            percentageCompleted = Double(completedTasks.count) / Double(tasks.count + completedTasks.count)
        } else {
            percentageCompleted = Double(0)
        }
    }
}

class Task: Identifiable & ObservableObject {
    
    let id: UUID
    var title: String
    var titleWithStrikethrough: Text
    var titleWithoutStrikethrough: Text
    
    var taskDone = false
    
    // reentryIndex stores the index the task was at when it was in the
    // incompleted tasks list. Useful for reverting a completed task
    // to incomplete and putting it in the correct order in the list.
    var reentryIndex: Int = -1
    
//    var opacity = 1
    
    
    init() {
        id = UUID()
        title = UUID().uuidString
        titleWithoutStrikethrough = Text(title)
        titleWithStrikethrough = Text(title).strikethrough(color: .white)
    }
    
    func changeTitle(new_title: String) {
        self.title = new_title
        titleWithoutStrikethrough = Text(self.title)
        titleWithStrikethrough = Text(self.title).strikethrough(color: .white)
    }
    
    func toggleTaskDone() {
        self.taskDone.toggle()
//        if self.taskDone {
//            self.title = self.titleWithStrikethrough
//        } else {
//            self.title = self.titleWithoutStrikethrough
//        }
        
    }
    
//    func setOpacity(opacity: Int) {
//        self.opacity = opacity
//    }
}

//struct Task_Previews: PreviewProvider {
//    var previews: some View {
//        Task()
//    }
//}
