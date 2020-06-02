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
//    @State var taskDone = false
    @State var rewardReached = false
    @State private var offset = CGSize.zero
    @State var title: String
    @State var desiredHeight: CGFloat = 60
    
    var viewMinHeight = CGFloat(60)
    var maxDragDistance = CGFloat(-50)
    
    var body: some View {
        GeometryReader { geo in
//            HStack {
                ZStack {
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
                                    if self.offset.width + 20 < self.maxDragDistance {
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
//                                if self.task.taskDone == true {
//                                    self.task.title = self.task.titleWithStrikethrough
//                                    self.rewards.calculateLowestRequiredCompletedTaskCount()
//                                    if self.rewards.isRewardReached(completedTasksCount: self.tasks.completedTasks.count) {
//                                        self.rewardReached = true
//                                    }
//                                } else {
//                                    self.task.title = self.task.titleWithoutStrikethrough
//                                }
                                
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
                            .sheet(isPresented: self.$rewardReached, onDismiss:
                                {
                                    self.rewards.transferReward(reward: self.rewards.rewards[0])
                                    self.rewards.calculateLowestRequiredCompletedTaskCount()

                            }) {
                                RewardReachedModal()
                                    .environmentObject(self.rewards)
                            }
                        }
                        GeometryReader { geo1 in
                            TextEditor(text: self.$title, task: self.task, desiredHeight: self.$desiredHeight)//, isHeightAdjustable: true)
    //                            , onCommit: {
    //                            self.task.title = self.title
    //                        })
                                .foregroundColor(self.task.taskDone ? Color.white : Color.black)
                                .padding(.trailing, 10)
                                .frame(width: geo1.size.width, height: self.desiredHeight)
                        }
                        Spacer()
                    }
                    .offset(x: self.offset.width < 0 ? self.offset.width : 0, y: 0)
                }
//            }
        }
//        .offset(x: offset.width < 0 ? offset.width : 0, y: 0)
//        .frame(minHeight: self.viewMinHeight)
        .frame(height: max(self.desiredHeight + 10, self.viewMinHeight))

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
