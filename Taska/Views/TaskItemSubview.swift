//
//  TaskItemSubview.swift
//  esportstracker
//
//  Created by Andrew Nguyen on 4/29/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct TaskItemSubview: View {
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    
    let task: Task
    @State var taskDone = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(self.taskDone ? Color.blue : Color.white)
                    .opacity(0.9)
                    .shadow(color: Colors.grey0, radius: 8, x: 0, y: 3)
                    .frame(width: geo.size.width * 0.9, height: 60)
                HStack() {
                    ZStack {
                        Button(action: {
                            self.taskDone.toggle()
                            self.lightImpact()
                            self.tasks.transferTask(task: self.task)
                            if self.taskDone == true {
                                self.task.title = self.task.titleWithStrikethrough
                                self.rewards.checkForCompletedReward(completedTasksCount: self.tasks.completedTasks.count)
                            } else {
                                self.task.title = self.task.titleWithoutStrikethrough
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 100, height: 100)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Colors.grey1, lineWidth: 3)
                                    //.padding(.leading, 40)
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                    self.task.title
                        .foregroundColor(self.taskDone ? Color.white : Color.black)
                    Spacer()
                }
            }
        }
        .frame(height: 60)
        .padding(.bottom, 0)
        .padding(.top, 0)
        .animation(.default)
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
