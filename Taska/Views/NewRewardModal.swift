//
//  NewRewardModal.swift
//  Rewarda
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import PartialSheet

struct NewRewardModal: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    
    //@Binding var isPresented: Bool
    var reward: Reward = Reward()
    @State var isTextFieldFirstResponder: Bool? = true
    @State var isTempFirstResponder: Bool? = false
    @State var new_title: String = String("")
    @State var completedTasksNeeded: Int = 1
    @State var textColor: UIColor = UIColor.black
    @State var desiredHeight: CGFloat = 0
    @State var clearOnEdit: Bool = true
    
    var completedTasksNeededRange = ["1","2","3","4","5","6","7","8","9","10"]
    
    
    
    var body: some View {
        GeometryReader { geo in
            VStack() {
                // Sets the reward title after user inputs into text field
                CustomTextField(placeholderText: "Add reward title", text: self.$new_title, desiredHeight: self.$desiredHeight, isFirstResponder: true, onCommit: {
  
                    if self.new_title != "" {
                        self.lightImpact()
                        self.reward.changeTitle(new_title: self.new_title)
                        self.reward.changeCompletedTasksNeeded(completedTasksNeeded: self.completedTasksNeeded)
                        self.rewards.addReward(reward: self.reward)
                        self.rewards.updateUpcomingReward()
                        print(Double(self.rewards.upcomingReward.completedTasks), Double(self.rewards.upcomingReward.completedTasksNeeded))
//                        if self.reward.completedTasksNeeded == self.rewards.rewards[0].completedTasksNeeded {
//                            self.rewards.updateUpcomingReward()
//                            self.tasks.completedTasksForNextReward = 0
//                        }
                    }
//                    self.rewards.calculatePercentageCompleted()
                    self.partialSheetManager.closePartialSheet()
//                    print(Double(self.tasks.completedTasksForNextReward), Double(max(self.rewards.lowestRequiredTotalCompletedTaskCount, 1)))
                })
                    .frame(width: geo.size.width, height: 40)
                
                self.stepper
//                    .offset(y: 10)
                
//                Spacer()
            }
//            .padding([.top, .bottom], 10)
//            .frame(height: geo.size.height)
        }
//        .frame(height: 140)
    }
    
    var stepper: some View {
        ZStack {
            Stepper("Rewarded after:", value: self.$completedTasksNeeded, in: 1...25)
            Text(String(self.completedTasksNeeded))
                .offset(x: -5)
                .frame(width: 100)
        }
    }
    
    var picker: some View {
        Picker(selection: self.$completedTasksNeeded, label: Text("Rewarded at:")) {
            ForEach(0 ..< self.completedTasksNeededRange.count) {
                Text(self.completedTasksNeededRange[$0])
            }
        }
        .frame(height: 140)
        .border(Color.green)
        .clipped()
        .allowsHitTesting(false)
    }
    
    func lightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
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
