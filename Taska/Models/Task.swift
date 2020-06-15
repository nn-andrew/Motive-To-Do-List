//
//  Task.swift
//  Taska
//
//  Created by Andrew Nguyen on 4/30/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import Foundation
import RealmSwift

class Tasks: ObservableObject {
    var rewards: Rewards = Rewards()
//    var tasks = [Task(), Task(), Task(), Task()]
    var tasks = [Task]()
    var completedTasks: [Task] = []
    var tasksForDeletion: [Task] = []
    var totalTasksCount: Int = 0
    var totalCompletedTasksCount: Int = 0
//    var completedTasksForNextReward: Int = 0
    @Published var percentageCompleted: Double = 0
    @Published var animated = true
    
    init() {
        
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        print(realmURL)
        
        // uncomment to clear realm files
//        let realmURLs = [
//            realmURL,
//            realmURL.appendingPathExtension("lock"),
//            realmURL.appendingPathExtension("note"),
//            realmURL.appendingPathExtension("management")
//        ]
//        for URL in realmURLs {
//            do {
//                try FileManager.default.removeItem(at: URL)
//            } catch {
//                // handle error
//            }
//        }
        
        do {
            let realm = try Realm()
            
            let results = realm.objects(Task.self)
            
            for task in results {
                if task.taskDone {
                    completedTasks.append(task)
                } else {
                    tasks.append(task)
                }
            }
        } catch {
            print("failed restoring past tasks")
        }
    }
    
    func save(task: Task) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(task)
        }
    }
    
    func addTask(task: Task) {
        tasks.insert(task, at: 0)
//        for task in completedTasks {
//            task.reentryIndex += 1
//        }
        task.reentryIndex = totalTasksCount
        totalTasksCount += 1
        print(tasks)
        
        save(task: task)
    }
    
    func removeAllCompletedTasks() {
        for task in completedTasks {
            removeTask(task: task)
        }
        totalTasksCount = tasks.count
        calculatePercentageCompleted()
    }
    
    func removeTask(task: Task) {
        //MARK: not removed immediately because View still depends on reference to task
        
        print("removeTask")
        let realm = try! Realm()
        try! realm.write {
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
        }
        
        tasksForDeletion.append(task)
        
//        let realm = try! Realm()
//        try! realm.write {
//            realm.delete(task)
//        }
        
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

public class Task: Object, Identifiable {
    
//    @objc dynamic public let id: UUID = UUID()
    @objc dynamic public var id: String = UUID().uuidString
    
    @objc dynamic var title: String = "untitled"
    
    @objc dynamic var taskDone = false
    
    // reentryIndex stores the index the task was at when it was in the
    // incompleted tasks list. Useful for reverting a completed task
    // to incomplete and putting it in the correct order in the list.
    @objc dynamic var reentryIndex: Int = -1
    
//    var opacity = 1
    
    required init() {
        
    }
    
    init(title: String) {
        self.title = title
    }
    
//    public override static func primaryKey() -> String {
//        return "createdAt"
//    }
    
    func toggleTaskDone() {
        let realm = try! Realm()
                
        try! realm.write {
            self.taskDone.toggle()
        }
    }
    
    func changeTitle(newTitle: String) {
        let realm = try! Realm()
        
        try! realm.write {
            self.title = newTitle
        }
    }
}
