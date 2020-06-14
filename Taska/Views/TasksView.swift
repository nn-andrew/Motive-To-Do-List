//
//  TasksView.swift
//  esportstracker
//
//  Created by Andrew Nguyen on 4/29/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet

struct TasksView: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    @State private var showModal: Bool = false
    
//    @State var hideCompletedTasks: Bool = false
    
    var body: some View {
        GeometryReader { geo in
//            NavigationView {
//                ZStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 242/255, green: 245/255, blue: 255/255))
                    .frame(width: geo.size.width, height: geo.size.height)
                VStack(spacing: 0) {
                    
                    // Dashboard
                    ZStack {
                        Rectangle()
//                            .fill(LinearGradient(gradient: Colors.blueGradient, startPoint: .leading, endPoint: .trailing))
                            .fill(Colors.blue2)
                            .frame(width: geo.size.width * 2, height: 320)
                            .position(x: geo.size.width * 0.5, y: 0)
//                            .padding(.top, -100)
                        
                        VStack(spacing: -40) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.partialSheetManager.showPartialSheet({
                                        
                                    }) {
                                        OptionsModal()//hideCompletedTasks: self.$hideCompletedTasks)
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 40, height: 40)
                                            .opacity(0)
                                        VStack(spacing: 4) {
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 4, height: 4)
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 4, height: 4)
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 4, height: 4)
                                        }

                                    }
                                }
                            }
                            .frame(width: geo.size.width * 0.90, height: 40)
                            
                            
                            DashboardSubview()
                                .frame(maxWidth: geo.size.width)
//                                .padding(.top, -30)
                            
                        }
                    }
                    .frame(height: 160)
//                    .padding(.top, -30)
                    
                    VStack {
                        //MARK: Version 1
//                        List(Array(Array(self.tasks.tasks + self.tasks.completedTasks).enumerated()), id: \.element.id) { i, item in
                        
//                        List(self.tasks.tasks + self.tasks.completedTasks) { item in
//                            TaskItemSubview(task: item, title: item.title)
////                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
//                                .padding(-2)
//                        }
//                        .transition(.opacity)
//                        .animation(self.tasks.animated ? .default : .none)
//                        .buttonStyle(PlainButtonStyle())
//                        .edgesIgnoringSafeArea(.all)
//                        .environment(\.defaultMinListRowHeight, 10)
//                        .padding([.top, .bottom], 10)
//                        .frame(width: geo.size.width)
//                        .frame(maxHeight: geo.size.height)

                        VStack {
//                            Image("avatar")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 200, height: 200)
//                                .animation(.easeOut(duration: 1))
//                                .opacity(self.tasks.tasks.count == 0 ? 0.7 : 0)
                            
                            //MARK: Version 2
                            ScrollView(showsIndicators: false) {
                                ForEach((Array(Array(self.tasks.tasks + self.tasks.completedTasks).enumerated())), id: \.element.id) { i, item in
                                    TaskItemSubview(task: item, title: item.title)
//                                        .opacity(item.taskDone == false || self.hideCompletedTasks == false ? 1 : 0) // is task completed and hidden? yes : no
//                                        .padding(item.taskDone == false || self.hideCompletedTasks == false ? 0 : -60)
                                        
                                }
                                .transition(.opacity)
                                .animation(self.tasks.animated ? .default : .none)
                                .buttonStyle(PlainButtonStyle())
        //                        .edgesIgnoringSafeArea(.all)
                                .environment(\.defaultMinListRowHeight, 10)
                                .padding(10)
                                .frame(width: geo.size.width)
//                                .frame(maxHeight: geo.size.height)
                            }
                        }
                        .padding([.top, .bottom], 10)
                    }
//                    .padding(.top, -40)
//                    .frame(width: 400)
                    
//                    Spacer()
                    
                    HStack {
                        Button(action: {
                            self.partialSheetManager.showPartialSheet({
                                print("text sheet dismissed")
                            }) {
                                NewTaskModal()
                                    .frame(width: geo.size.width * 0.8)
                            }
                            
                        }) {
                            self.AddTaskButton
                                .frame(minWidth: geo.size.width * 0.6, maxWidth: geo.size.width * 0.9, minHeight: 60, maxHeight: 60)
                        }
                        
                        Button(action: {
                            self.partialSheetManager.showPartialSheet({
                                print("text sheet dismissed")
                            }) {
                                NewRewardModal()
                                    .frame(width: geo.size.width * 0.8)
                            }
                        }) {
                            self.AddRewardButton
                                .frame(maxWidth: geo.size.width * 0.3, minHeight: 60, maxHeight: 60)
                        }
                    }
                    .padding([.leading, .trailing], 20)
//                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.32)
    //                .padding([.leading, .trailing], 100)
                    
//                    Spacer()
                }
                .frame(height: geo.size.height-60)
                .padding(.top, -30)

            }
//            .frame(width: geo.size.width, height: geo.size.height)
        }
        .addPartialSheet()
        .edgesIgnoringSafeArea(.bottom)
    }
    
//    @ViewBuilder
//    var buildItemView: some View {
//        if item.taskDone == false || self.hideCompletedTasks == false {
//            return TaskItemSubview(task: item, title: item.title)
//        }
//    }
    
    var AddTaskButton: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Colors.blue2)
                    .opacity(0.3)
                    .frame(width: geo.size.width, height: geo.size.height)
                .frame(height: 60)
                HStack {
                    Rectangle()
                        .fill(Color.white)
                        .opacity(0.8)
                        .mask(
                            Image("plus")
                            .resizable()
                            .scaledToFit()
                        )
                        .frame(width: 30, height: 30)
                    Spacer()
                }
                .padding(.leading, 16)
            }
        }
    }
    
    var AddRewardButton: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Colors.blue2)
                    .opacity(0.3)
                    .frame(width: geo.size.width, height: geo.size.height)
                HStack {
                    Rectangle()
                        .fill(Color.white)
                        .opacity(0.8)
                        .mask(
                            Image("star")
                            .resizable()
                            .scaledToFit()
                        )
                        .frame(width: 30, height: 30)
                    Spacer()
                }
                .padding(.leading, 16)
            }
        }
    }
}



struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
