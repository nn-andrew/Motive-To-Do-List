//
//  Reward.swift
//  Rewarda
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import Foundation
import RealmSwift

class Rewards: ObservableObject {
    @EnvironmentObject var tasks: Tasks
    var rewards = [Reward]()
//    var completedRewards: [Reward] = []
    var percentageCompleted: Double = 0
//    @Published var lowestRequiredTotalCompletedTaskCount: Int = 1
    @Published var upcomingReward: Reward = Reward()
    
    
    
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
            
            let results = realm.objects(Reward.self)
            
            for reward in results {
                rewards.append(reward)
            }
        } catch {
            print("failed restoring past rewards")
        }
        
        updateUpcomingReward()
    }
    
    func save(reward: Reward) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(reward)
        }
    }
    
    func addReward(reward: Reward) {

        if rewards.count > 0 {
            if let index = rewards.firstIndex(where: {$0.completedTasksNeeded - $0.completedTasks == reward.completedTasksNeeded - reward.completedTasks}) {
                reward.changeTitle(new_title: "\(rewards[0].title), \(reward.title)")
                removeReward(index: index)
            }
        }
            
        rewards.append(reward)
        if rewards.count > 1 {
            rewards.sort {
                $0.completedTasksNeeded - $0.completedTasks < $1.completedTasksNeeded - $1.completedTasks
            }
        }
//        if shouldUpdate {
            updateUpcomingReward()
//        }
        print(rewards)
        
        save(reward: reward)
    }
    
    func removeReward(index: Int) {
        print("removeReward")
        let realm = try! Realm()
        
        try! realm.write {
            if rewards.count > 0 {
                realm.delete(rewards[index])
                rewards.remove(at: index)
            }
        }
            
        updateUpcomingReward()
        
        if rewards.count == 0 {
            upcomingReward = Reward()
        }
//        calculatePercentageCompleted()
    }
    
//    func calculatePercentageCompleted() {
//        percentageCompleted = Double(completedRewards.count) / Double(rewards.count + completedRewards.count)
//    }
    
//    func updateUpcomingReward() -> Reward {
//        if rewards.count == 0 {
//            return Reward()
//        } else {
//            var updateUpcomingReward = rewards[0]
//
//            for reward in rewards {
//                if reward.completedTasksNeeded < updateUpcomingReward.completedTasksNeeded {
//                    updateUpcomingReward = reward
//                }
//            }
//
//            return updateUpcomingReward
//        }
//    }
    
    func updateUpcomingReward() {
        // determine the which reward is closest to being reached
//        var newUpcomingReward: Reward = Reward()
//        var resultFound: Bool = false
        
//        for reward in rewards {
//            if reward.completedTasksNeeded - reward.completedTasks < upcomingReward.completedTasksNeeded - upcomingReward.completedTasks {
//                newUpcomingReward = reward
////                resultFound = true
//            }
//            else if reward.completedTasksNeeded - reward.completedTasks == upcomingReward.completedTasksNeeded - upcomingReward.completedTasks {
//                newUpcomingReward = reward
//            }
//        }
//
//        upcomingReward = newUpcomingReward
//        if rewards.count > 1 {
//            if rewards[0].completedTasksNeeded - rewards[0].completedTasks == rewards[1].completedTasksNeeded - rewards[1].completedTasks {
//                rewards[0].changeTitle(new_title: "\(rewards[0].title), \(rewards[1].title)")
//                removeReward(index: 1)
//            }
//        }
        if rewards.count > 0 {
            upcomingReward = rewards[0]
        }
//        print(newUpcomingReward)
    }
    
    func isRewardReached(completedTasksCount: Int) -> Bool {
        // returns true if a reward has been reached
//        print(completedTasksCount, reward.completedTasksNeeded)
        if rewards.count > 0 {
            if rewards[0].completedTasks >= rewards[0].completedTasksNeeded {
                //transferReward(reward: rewards[0])
                return true
            }
        }
        
        return false
    }
    
}

class Reward: Object, Identifiable {
    
    @objc dynamic let id: String = UUID().uuidString
    @objc dynamic var title: String
    @objc dynamic var completedTasksNeeded: Int
    @objc dynamic var completedTasks: Int
    @objc dynamic var rewardDone = false
    
    
    required init() {
//        id = UUID()
        title = "temp"
        completedTasksNeeded = 99
        completedTasks = 0
    }
    
    func changeTitle(new_title: String) {
        let realm = try! Realm()
        
        try! realm.write {
            self.title = new_title
        }
    }
    
    func changeCompletedTasks(completedTasks: Int) {
        let realm = try! Realm()
        
        try! realm.write {
            self.completedTasks = completedTasks
        }
    }
    
    func changeCompletedTasksNeeded(completedTasksNeeded: Int) {
        let realm = try! Realm()
        
        try! realm.write {
            self.completedTasksNeeded = completedTasksNeeded
        }
    }
    
    func toggleRewardDone() {
        let realm = try! Realm()
        
        try! realm.write {
            self.rewardDone.toggle()
        }
    }
}
