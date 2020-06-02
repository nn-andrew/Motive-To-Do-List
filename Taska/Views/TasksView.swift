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
                                        OptionsModal()
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

                        //MARK: Version 2
                        ScrollView {
                            ForEach((Array(Array(self.tasks.tasks + self.tasks.completedTasks).enumerated())), id: \.element.id) { i, item in
                                TaskItemSubview(task: item, title: item.title)
                                .padding(-1)
                            }
                        .transition(.opacity)
                        .animation(self.tasks.animated ? .default : .none)
                        .buttonStyle(PlainButtonStyle())
//                        .edgesIgnoringSafeArea(.all)
                        .environment(\.defaultMinListRowHeight, 10)
                        .padding(10)
                        .frame(width: geo.size.width)
                        .frame(maxHeight: geo.size.height)
                        }
                        .padding([.top, .bottom], 10)
                        
                        
//                        if self.tasks.tasks.count == 0 {
//                            HStack {
//                                Spacer()
//                            }
//                        }
//                        Capsule()
//                            .fill(Colors.grey1)
//                            .frame(width: 60, height: 10)
//                            .padding(.top, 36)
//                            .animation(.default)
//                        ForEach(self.tasks.completedTasks) { completedTask in
//                            TaskItemSubview(task: completedTask)
//                            .animation(.default)
//                        }
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
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Colors.blue2)
                                    .opacity(0.2)
                                    .frame(minWidth: geo.size.width * 0.6, maxWidth: geo.size.width * 0.9, minHeight: 60, maxHeight: 60)
    //                            HStack() {
    //                                Spacer()
    //                            }
                                .frame(height: 60)
                            }
                            
                        }
                        
                        Button(action: {
                            self.partialSheetManager.showPartialSheet({
                                print("text sheet dismissed")
                            }) {
                                NewRewardModal()
                                    .frame(width: geo.size.width * 0.8)
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Colors.blue2)
                                    .opacity(0.2)
                                    .frame(maxWidth: geo.size.width * 0.3, minHeight: 60, maxHeight: 60)
                                    //.frame(height: 60)
                            }
                            
                        }
                    }
//                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.32)
    //                .padding([.leading, .trailing], 100)
                    
//                    Spacer()
                }
                .frame(height: geo.size.height-60)
                .padding(.top, -30)
                
    //                    RewardReachedModal()
    //                }
    //            }
    //            .addPartialSheet()
    //            .navigationBarTitle("")
    //            .navigationBarHidden(true)
    //            .navigationBarBackButtonHidden(true)
            }
//            .frame(width: geo.size.width, height: geo.size.height)
        }
        .addPartialSheet()
        .edgesIgnoringSafeArea(.bottom)
    }
}



struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
