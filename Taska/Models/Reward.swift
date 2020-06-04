//
//  Reward.swift
//  Rewarda
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import Foundation


class Rewards: ObservableObject {
    @EnvironmentObject var tasks: Tasks
    var rewards = [Reward]()
//    var completedRewards: [Reward] = []
    var percentageCompleted: Double = 0
//    @Published var lowestRequiredTotalCompletedTaskCount: Int = 1
    @Published var upcomingReward: Reward = Reward()
    
    func addReward(reward: Reward) {
//        var shouldUpdate: Bool = true
        if let index = rewards.firstIndex(where: {$0.completedTasksNeeded - $0.completedTasks == reward.completedTasksNeeded - reward.completedTasks}) {
            rewards.remove(at: index)
//            shouldUpdate = false
        }
        rewards.append(reward)
        if rewards.count > 1 {
            rewards.sort {
                $0.completedTasksNeeded < $1.completedTasksNeeded
            }
        }
//        if shouldUpdate {
            updateUpcomingReward()
//        }
        print(rewards)
    }
    
    func removeReward() {
        if rewards.count > 0 {
            rewards.remove(at: 0)
        }

        updateUpcomingReward()
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
        var newUpcomingReward: Reward = Reward()
//        var resultFound: Bool = false
        for reward in rewards {
            if reward.completedTasksNeeded - reward.completedTasks <= upcomingReward.completedTasksNeeded - upcomingReward.completedTasks {
                newUpcomingReward = reward
//                resultFound = true
            }
        }
        
        upcomingReward = newUpcomingReward
    }
    
    func isRewardReached(completedTasksCount: Int) -> Bool {
        // returns true if a reward has been reached
//        print(completedTasksCount, reward.completedTasksNeeded)
        if rewards.count > 0 {
            if upcomingReward.completedTasks >= upcomingReward.completedTasksNeeded {
                //transferReward(reward: rewards[0])
                return true
            }
        }
        
        return false
    }
    
}

class Reward: Identifiable & ObservableObject {
    
    let id: UUID
    var title: Text
    var titleWithStrikethrough: Text
    var titleWithoutStrikethrough: Text
    var completedTasksNeeded: Int
    var completedTasks: Int
    var rewardDone = false
    
    
    init() {
        id = UUID()
        title = Text("temp")
        titleWithoutStrikethrough = Text("temp")
        titleWithStrikethrough = Text("temp").strikethrough(color: .white)
        completedTasksNeeded = 99
        completedTasks = 0
    }
    
    func changeTitle(new_title: Text) {
        self.title = new_title
        titleWithoutStrikethrough = self.title
        titleWithStrikethrough = self.title.strikethrough(color: .white)
    }
    
    func changeCompletedTasksNeeded(completedTasksNeeded: Int) {
        self.completedTasksNeeded = completedTasksNeeded
    }
    
    func toggleRewardDone() {
        self.rewardDone.toggle()
        if self.rewardDone {
            self.title = self.titleWithStrikethrough
        } else {
            self.title = self.titleWithoutStrikethrough
        }
        
    }
}
