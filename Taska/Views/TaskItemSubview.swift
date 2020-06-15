//
//  TaskItemSubview.swift
//  Taska
//
//  Created by Andrew Nguyen on 4/29/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import PartialSheet
import UIKit

struct TaskItemSubview: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    
    var task: Task
//    var index: Int
//    @State var taskDone = false
    @State var rewardReached = false
    @State private var offset = CGSize.zero
    @State var title: String
    @State var desiredHeight: CGFloat = 60
    @State var taskDone: Bool = false

//    @State var backLayerOpacity: Double = 0
    var viewMinHeight = CGFloat(60)
    var maxDragDistance = CGFloat(-70)
    
    var body: some View {
        GeometryReader { geo in
//            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
//                        .stroke(Color.red)
                        .shadow(color: Colors.blue2, radius: 3, x: 0, y: 2)
                        .opacity(0.1)
//                        .clipShape(
//                            RoundedRectangle(cornerRadius: 18)
//                        )
                    RoundedRectangle(cornerRadius: 18)
                        .fill(self.colorScheme == .light ? Colors.lightModeTaskRemove : Colors.darkModeTaskRemove)
//                        .opacity(self.backLayerOpacity)
                        .shadow(color: Colors.blue2.opacity(0.1), radius: 3, x: 0, y: 3)
                        .frame(width: geo.size.width)
                        .frame(minHeight: self.viewMinHeight)
                        .overlay(
                            HStack {
                                Spacer()
                                Image("trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26.0, height: 26)
                            }
                            .padding(.trailing, 16)
                            .offset(x: { () -> CGFloat in
                                if self.offset.width < 0 {
                                    if self.offset.width < self.maxDragDistance {
                                        return 0
                                    }
                                    return self.offset.width + 70
                                }
                                return 100
                            }())
                                .animation(.none)
                        )
                        .mask(
                            RoundedRectangle(cornerRadius: 18)
                        )
                    RoundedRectangle(cornerRadius: 18)
                        .fill(self.task.taskDone ? (self.colorScheme == .light ? Colors.lightModeTaskCompleted : Colors.darkModeTaskCompleted) : (self.colorScheme == .light ? Colors.lightModeTaskIncomplete : Colors.darkModeTaskIncomplete))
//                        .opacity(0.9)
                        .frame(width: geo.size.width+1)
                        .frame(minHeight: self.viewMinHeight + 1)
                        .offset(x: self.offset.width < 0 ? self.offset.width : 0, y: 0)
                    HStack() {
                        ZStack {
                            Button(action: {
                                self.taskDone = true
                                
                                self.tasks.animated = true
                                self.task.toggleTaskDone()
                                self.lightImpact()
                                self.tasks.transferTask(task: self.task)
                                self.rewards.updateUpcomingReward()
                                if self.task.taskDone == true {
//                                    self.task.title = self.task.titleWithStrikethrough
                                    
                                    self.tasks.totalCompletedTasksCount += 1
                                    for reward in self.rewards.rewards {
                                        reward.changeCompletedTasks(completedTasks: reward.completedTasks + 1)
                                    }
                                    
                                    if self.rewards.isRewardReached(completedTasksCount: self.rewards.upcomingReward.completedTasks) {
                                        self.rewardReached = true
                                        self.partialSheetManager.showPartialSheet({
//                                            self.rewards.removeReward(index: 0)
                                            self.rewards.updateUpcomingReward()
//                                            self.tasks.completedTasksForNextReward = 0
                                        }) {
                                            RewardReachedModal()
                                                .environmentObject(self.rewards)
                                                .frame(height: UIScreen.main.bounds.size.height * 0.6)
                                        }
                                        
                                    }
                                } else {
                                    self.taskDone = false
                                    
                                    if self.tasks.totalCompletedTasksCount > 0 {
                                        self.tasks.totalCompletedTasksCount -= 1
                                    }
                                    for reward in self.rewards.rewards {
                                        if reward.completedTasks > 0 {
                                            reward.changeCompletedTasks(completedTasks: reward.completedTasks - 1)
//                                            reward.completedTasks -= 1
                                        }
                                    }
                                }
                                print(Double(self.rewards.upcomingReward.completedTasks), Double(self.rewards.upcomingReward.completedTasksNeeded))
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.white)
                                        .opacity(0.001)
                                        .frame(width: 60, height: 60)
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(self.colorScheme == .light ? Colors.grey1 : (self.taskDone ? Colors.grey2 : Colors.grey2), lineWidth: 3)
                                        //.padding(.leading, 40)
                                        .frame(width: 30, height: 30)
                                    
                                    Rectangle()
                                        .fill(Colors.grey1)
                                        .frame(width: 20, height: 20)
                                        .mask(
                                            Image("checkmark")
                                                .resizable()
                                                .scaledToFit()
                                        )
                                        .opacity(self.task.taskDone ? 1 : 0)
                                }
                            }
                        }
                        GeometryReader { geo1 in
                            VStack {
                                Spacer()
                                CustomTextView(text: self.$title, taskDone: self.$taskDone, desiredHeight: self.$desiredHeight, onCommit: {
                                    if self.title == "" {
                                        self.tasks.removeTask(task: self.task)
                                    } else {
                                        self.task.changeTitle(newTitle: self.title)
                                    }
                                })
//                                    .foregroundColor(self.task.taskDone ? Color.white : Color.black)
                                    .padding(.trailing, 10)
                                    .frame(width: geo1.size.width, height: self.desiredHeight + 1)
                                Spacer()
                            }
                            .frame(height: geo1.size.height)
                        }
                        Spacer()
                    }
                    .offset(x: self.offset.width < 0 ? self.offset.width : 0, y: 0)
                }
//            }
        }
//        .offset(x: offset.width < 0 ? offset.width : 0, y: 0)
//        .frame(minHeight: self.viewMinHeight)
        .frame(height: max(self.desiredHeight+10, self.viewMinHeight))
        .onAppear(perform: {
            if self.task.taskDone {
                self.taskDone = true
            }
        })
            
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onChanged { gesture in
                    self.tasks.animated = false
                    self.offset = gesture.translation
//                    self.backLayerOpacity = 1
                }
                .onEnded { gesture in
                    self.tasks.animated = true
                    if self.offset.width < self.maxDragDistance {
                        self.tasks.removeTask(task: self.task)
                    } else {
                        self.offset = .zero
                    }
//                    self.backLayerOpacity = 0
                }
        )
    }
    
    func lightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}

struct TaskItemSubview_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemSubview(task: Task(), title: "temp")
    }
}
