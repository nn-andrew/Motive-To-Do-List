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
    @State private var showModal: Bool = false
    
    var body: some View {
        GeometryReader { geo in
        NavigationView {
            VStack {
                DashboardSubview()
                    .padding(.top, -180)
                    .frame(maxWidth: geo.size.width)
                    
//                    .offset(y: -180)
//                    .padding(.bottom, -170)
                
                VStack {
                    ScrollView(.vertical) {
                        ForEach(self.tasks.tasks) { task in
                            //Text(task.title)
                            TaskItemSubview(task: task)
                        }
                        if self.tasks.tasks.count == 0 {
                            HStack {
                                Spacer()
                            }
                        }
                        Divider()
                            .padding(.top, 36)
                        ForEach(self.tasks.completedTasks) { completedTask in
                            TaskItemSubview(task: completedTask)
                        }
                    }
    //                .border(Color.black)
                    .frame(width: 400, height: 510)
                    
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
                                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.1)
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color.black)
                                    .opacity(0.08)
                                    .frame(maxWidth: geo.size.width * 0.3, minHeight: 60, maxHeight: 60)
    //                            HStack() {
    //                                Spacer()
    //                            }
                                .frame(height: 60)
                            }
                            
                        }
                    }
                }
                .padding([.leading, .trailing], 100)
                
            }
        }
        .addPartialSheet()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
