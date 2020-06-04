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
    @Published var lowestRequiredTotalCompletedTaskCount: Int = 1
    
    func addReward(reward: Reward) {
        rewards.append(reward)
        if rewards.count > 1 {
            rewards.sort {
                $0.completedTasksNeeded < $1.completedTasksNeeded
            }
        }
        calculatelowestRequiredTotalCompletedTaskCount()
        print(rewards)
    }
    
    func removeReward() {
        print("hi2")
        rewards.remove(at: 0)

        calculatelowestRequiredTotalCompletedTaskCount()
//        calculatePercentageCompleted()
    }
    
//    func calculatePercentageCompleted() {
//        percentageCompleted = Double(completedRewards.count) / Double(rewards.count + completedRewards.count)
//    }
    
//    func upcomingReward() -> Reward {
//        if rewards.count == 0 {
//            return Reward()
//        } else {
//            var upcomingReward = rewards[0]
//
//            for reward in rewards {
//                if reward.completedTasksNeeded < upcomingReward.completedTasksNeeded {
//                    upcomingReward = reward
//                }
//            }
//
//            return upcomingReward
//        }
//    }
    
    func calculatelowestRequiredTotalCompletedTaskCount() {
        if rewards.count == 0 {
            lowestRequiredTotalCompletedTaskCount = 1
        } else {
            lowestRequiredTotalCompletedTaskCount = rewards[0].completedTasksNeeded
        }
    }
    
    func isRewardReached(completedTasksCount: Int) -> Bool {
        // returns true if a reward has been reached
//        print(completedTasksCount, reward.completedTasksNeeded)
        if rewards.count > 0 {
            if completedTasksCount >= rewards[0].completedTasksNeeded {
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
    
    var rewardDone = false
    
    
    init() {
        id = UUID()
        title = Text("temp")
        titleWithoutStrikethrough = Text("temp")
        titleWithStrikethrough = Text("temp").strikethrough(color: .white)
        completedTasksNeeded = 1
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
