//
//  TaskItemSubview.swift
//  esportstracker
//
//  Created by Andrew Nguyen on 4/29/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet
import UIKit

struct TaskItemSubview: View {
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
                        .fill(Colors.red2)
//                        .opacity(1)
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
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 18)
//                                .stroke(Color.red)
//                                .shadow(color: Colors.blue2, radius: 3, x: -2, y: -2)
//                                .clipShape(
//                                    RoundedRectangle(cornerRadius: 18)
//                                )
//                        )
                    RoundedRectangle(cornerRadius: 18)
                        .fill(self.task.taskDone ? Colors.blue2 : Color.white)
//                        .opacity(0.9)
                        .frame(width: geo.size.width+1)
                        .frame(minHeight: self.viewMinHeight + 1)
                        .offset(x: self.offset.width < 0 ? self.offset.width : 0, y: 0)
                    HStack() {
                        ZStack {
                            Button(action: {
                                self.tasks.animated = true
                                self.task.taskDone.toggle()
                                self.lightImpact()
                                self.tasks.transferTask(task: self.task)
                                self.rewards.updateUpcomingReward()
                                if self.task.taskDone == true {
//                                    self.task.title = self.task.titleWithStrikethrough
                                    self.tasks.totalCompletedTasksCount += 1
                                    for reward in self.rewards.rewards {
                                        reward.completedTasks += 1
                                    }
                                    
                                    if self.rewards.isRewardReached(completedTasksCount: self.rewards.upcomingReward.completedTasks) {
                                        self.rewardReached = true
                                        self.partialSheetManager.showPartialSheet({
                                            self.rewards.removeReward()
                                            self.rewards.updateUpcomingReward()
//                                            self.tasks.completedTasksForNextReward = 0
                                        }) {
                                            RewardReachedModal()
                                                .environmentObject(self.rewards)
                                                .frame(height: UIScreen.main.bounds.size.height * 0.6)
                                        }
                                        
                                    }
                                } else {
                                    if self.tasks.totalCompletedTasksCount > 0 {
                                        self.tasks.totalCompletedTasksCount -= 1
                                    }
//                                    if self.rewards.lowestRequiredTotalCompletedTaskCount - 1 >= 0 {
//                                        self.rewards.lowestRequiredTotalCompletedTaskCount -= 1
//                                    }
                                    for reward in self.rewards.rewards {
                                        if reward.completedTasks > 0 {
                                            reward.completedTasks -= 1
                                        }
                                    }
//                                    self.task.title = self.task.titleWithoutStrikethrough
                                }
                                print(Double(self.rewards.upcomingReward.completedTasks), Double(self.rewards.upcomingReward.completedTasksNeeded))
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.white)
                                        .opacity(0.001)
                                        .frame(width: 60, height: 60)
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Colors.grey1, lineWidth: 3)
                                        //.padding(.leading, 40)
                                        .frame(width: 30, height: 30)
                                }
                            }
//                            .sheet(isPresented: self.$rewardReached, onDismiss:
//                                {
//                                    self.rewards.transferReward(reward: self.rewards.rewards[0])
//                                    self.rewards.updateUpcomingReward()
//
//                            }) {
//                                RewardReachedModal()
//                                    .environmentObject(self.rewards)
//                            }
                        }
                        GeometryReader { geo1 in
                            VStack {
                                Spacer()
                                TextEditor(text: self.$title, task: self.task, desiredHeight: self.$desiredHeight, isFirstResponder: false, onCommit: {})//, isHeightAdjustable: true)
        //                            , onCommit: {
        //                            self.task.title = self.title
        //                        })
                                    .foregroundColor(self.task.taskDone ? Color.white : Color.black)
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

        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onChanged { gesture in
                    self.tasks.animated = false
                    self.offset = gesture.translation
//                    print(self.tasks.animated)
                }
                .onEnded { gesture in
                    self.tasks.animated = true
                    if self.offset.width < self.maxDragDistance {
                        self.tasks.removeTask(task: self.task)
//                        self.tasks.tasks.remove(at: self.index)
                    } else {
                        self.offset = .zero
                    }
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
