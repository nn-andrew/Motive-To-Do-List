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
    @Published var rewards = [Reward]()
    @Published var completedRewards: [Reward] = []
    @Published var percentageCompleted: Double = 0
    
    func addReward(reward: Reward) {
        self.rewards.append(reward)
        print(self.rewards)
    }
    
    func transferReward(reward: Reward) {
        if let index = rewards.firstIndex(where: {$0.id == reward.id}) {
            rewards.remove(at: index)
            completedRewards.insert(reward, at: 0)
        } else {
            if let index = completedRewards.firstIndex(where: {$0.id == reward.id}) {
                completedRewards.remove(at: index)
                rewards.insert(reward, at: 0)
            }
        }
        calculatePercentageCompleted()
    }
    
    func calculatePercentageCompleted() {
        percentageCompleted = Double(completedRewards.count) / Double(rewards.count + completedRewards.count)
    }
    
    func lowestRequiredCompletedTaskCount() -> Int {
        if rewards.count == 0 {
            return 1
        } else {
            var min = rewards[0].completedTasksNeeded

            for reward in rewards {
                if reward.completedTasksNeeded < min {
                    min = reward.completedTasksNeeded
                }
            }
            
            return min
        }
    }
    
    func checkForCompletedReward(completedTasksCount: Int) {
        for reward in rewards {
            print(completedTasksCount, reward.completedTasksNeeded)
            if completedTasksCount >= reward.completedTasksNeeded {
                print("rewarded, congrats!")
            }
        }
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
        completedTasksNeeded = 0
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
