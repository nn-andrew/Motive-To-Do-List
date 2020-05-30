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
//                    .border(Color.yellow)
                    .frame(width: geo.size.width, height: geo.size.height)
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
//                            .fill(LinearGradient(gradient: Colors.blueGradient, startPoint: .leading, endPoint: .trailing))
                            .fill(Colors.blue2)
                            .frame(width: geo.size.width + 1, height: 240)
                            .padding(.top, -100)
                        
                        VStack(spacing: -70) {
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
    //                                .padding(.top, -100)
                                .frame(maxWidth: geo.size.width)
                            
                        }
                    }
    //                        .opacity(0)
                    
                    VStack {
                            //MARK: Version 1
                            List(self.tasks.tasks + self.tasks.completedTasks) { item in
                                TaskItemSubview(task: item)
                                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
//                                    .shadow(color: .black, radius: 8, x: 0, y: 3)
    //                                .listRowBackground(Color(red: 214, green: 227, blue: 255))
                                    .frame(height: 56)
                                    
                            }
                            .transition(.opacity)
                            .animation(self.tasks.animated ? .default : .none)
                            .buttonStyle(PlainButtonStyle())
                            .edgesIgnoringSafeArea(.all)
                            .environment(\.defaultMinListRowHeight, 10)
                            .frame(width: geo.size.width, height: geo.size.height * 0.6)

                            //MARK: Version 2
    //                        List {
    //                            ForEach(self.tasks.tasks + self.tasks.completedTasks) { item in
    //                                TaskItemSubview(task: item)
    //                                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    //                            }
    //                        }
    //                        .buttonStyle(PlainButtonStyle())
    //                        .edgesIgnoringSafeArea(.all)
    //                        .frame(width: geo.size.width, height: geo.size.height)
                            
                            
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
                        .frame(width: 400, height: 490)
                        
                        HStack {
                            Button(action: {
                                self.partialSheetManager.showPartialSheet({
                                    print("text sheet dismissed")
                                }) {
                                    NewTaskModal()
                                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.1)
                                }
                                
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color.black)
                                        .opacity(0.08)
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
                                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
    //                                            .border(Color.red)
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color.black)
                                        .opacity(0.08)
                                        .frame(maxWidth: geo.size.width * 0.3, minHeight: 60, maxHeight: 60)
                                        //.frame(height: 60)
                                }
                                
                            }
    //                        .border(Color.red)
    //                    }
                    }
    //                .padding([.leading, .trailing], 100)
    //                        .border(Color.green)
                }
    //            .border(Color.yellow)
    //                    RewardReachedModal()
    //                }
    //            }
    //            .addPartialSheet()
    //            .navigationBarTitle("")
    //            .navigationBarHidden(true)
    //            .navigationBarBackButtonHidden(true)
            }
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
