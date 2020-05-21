//
//  NewRewardModal.swift
//  Rewarda
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet

struct NewRewardModal: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var rewards: Rewards
    
    //@Binding var isPresented: Bool
    var reward: Reward = Reward()
    @State var isTextFieldFirstResponder: Bool? = true
    @State var isTempFirstResponder: Bool? = false
    @State var new_title: String = String("")
    @State var completedTasksNeeded: Int = 1
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                // Sets the reward title after user inputs into text field
                TextField("Add reward title", text: self.$new_title, onCommit: {
                    self.reward.changeTitle(new_title: Text(self.new_title))
                    self.reward.changeCompletedTasksNeeded(completedTasksNeeded: self.completedTasksNeeded)
                    self.rewards.addReward(reward: self.reward)
                    self.rewards.calculatePercentageCompleted()
                    self.partialSheetManager.closePartialSheet()

                })
                
                ZStack {
                    Stepper("Rewarded at:", value: self.$completedTasksNeeded, in: 1...99)
                    Text(String(self.completedTasksNeeded))
                        .offset(x: -20)
                }
            }
        }
    }
}

//struct NewRewardModal_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRewardModal(isPresented: , reward: Reward())
//    }
//}

struct NewRewardModal_Previews: PreviewProvider {
    static var previews: some View {
        NewRewardModal()
    }
}
