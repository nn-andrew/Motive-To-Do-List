//
//  TaskItemSubview.swift
//  esportstracker
//
//  Created by Andrew Nguyen on 4/29/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet

struct TaskItemSubview: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    
    var task: Task
//    var index: Int
    @State var taskDone = false
    @State var rewardReached = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in
//            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Colors.red2)
                        .opacity(1)
                        .shadow(color: Colors.blue2.opacity(0.1), radius: 3, x: 0, y: 3)
                        .frame(width: geo.size.width, height: 60)
                    RoundedRectangle(cornerRadius: 18)
                        .fill(self.taskDone ? Colors.blue2 : Color.white)
//                        .opacity(0.9)
                        .frame(width: geo.size.width+1, height: 60+1)
                        .offset(x: self.offset.width < 0 ? self.offset.width : 0, y: 0)
                    HStack() {
                        ZStack {
                            Button(action: {
                                self.tasks.animated = false
                                self.taskDone.toggle()
                                self.lightImpact()
                                self.tasks.transferTask(task: self.task)
                                if self.taskDone == true {
                                    self.task.title = self.task.titleWithStrikethrough
                                    self.rewards.calculateLowestRequiredCompletedTaskCount()
                                    if self.rewards.isRewardReached(completedTasksCount: self.tasks.completedTasks.count) {
                                        self.rewardReached = true
                                    }
                                } else {
                                    self.task.title = self.task.titleWithoutStrikethrough
                                }
                                
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.white)
                                        .opacity(0.001)
                                        .frame(width: 70, height: 60)
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Colors.grey1, lineWidth: 3)
                                        //.padding(.leading, 40)
                                        .frame(width: 30, height: 30)
                                }
                            }
                            .sheet(isPresented: self.$rewardReached, onDismiss:
                                {
                                    self.rewards.transferReward(reward: self.rewards.rewards[0])
                                    self.rewards.calculateLowestRequiredCompletedTaskCount()

                            }) {
                                RewardReachedModal()
                                    .environmentObject(self.rewards)
                            }
                        }
                        self.task.title
                            .foregroundColor(self.taskDone ? Color.white : Color.black)
                        Spacer()
                    }
                    .offset(x: self.offset.width < 0 ? self.offset.width : 0, y: 0)
                }
//            }
        }
//        .offset(x: offset.width < 0 ? offset.width : 0, y: 0)
        .frame(height: 60)
        .padding(.bottom, 0)
        .padding(.top, 0)
//        .animation(self.animation ? .easeInOut: .none)

        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onChanged { gesture in
                    self.tasks.animated = false
                    self.offset = gesture.translation
//                    print(self.tasks.animated)
                }
                .onEnded { gesture in
                    self.tasks.animated = true
                    if self.offset.width < -100 {
//                        self.task.hidden = true
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
        TaskItemSubview(task: Task())
    }
}
