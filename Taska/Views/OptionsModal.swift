//
//  OptionsModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/5/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import PartialSheet

struct OptionsModal: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    
//    @Binding var hideCompletedTasks: Bool
//    @State var presentEditRewardsModal: Bool = false
    @State var showRemoveAllRewardsAlert: Bool = false
    @State var showRemoveAllCompletedTasksAlert: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                
//                Button(action: {
//                    self.hideCompletedTasks.toggle()
//                    self.partialSheetManager.closePartialSheet()
//                }) {
//                    Text(self.hideCompletedTasks ? "Unhide completed tasks" : "Hide completed tasks")
//                        .foregroundColor(.blue)
//                }
                
                Button(action: {
                    self.showRemoveAllCompletedTasksAlert = true
                }) {
                    Text("Remove all completed tasks")
                        .foregroundColor(.red)
                }
                .actionSheet(isPresented: self.$showRemoveAllCompletedTasksAlert) {
                    ActionSheet(title: Text("All completed tasks will be permanently deleted."), buttons: [
                        .destructive(Text("Delete")) {
                            for task in self.tasks.completedTasks {
                                self.tasks.removeTask(task: task)
                            }
                            self.tasks.completedTasks.removeAll()
                            self.tasks.calculatePercentageCompleted()
                            self.partialSheetManager.closePartialSheet()
                        },
                        .default(Text("Cancel"))
                    ])
                }
                
                Button(action: {
                    self.showRemoveAllRewardsAlert = true
                }) {
                    Text("Remove all rewards")
                        .foregroundColor(.red)
                }
                .actionSheet(isPresented: self.$showRemoveAllRewardsAlert) {
                    ActionSheet(title: Text("All rewards will be permanently deleted."), buttons: [
                        .destructive(Text("Delete")) {
                            for _ in self.rewards.rewards {
                                self.rewards.removeReward(index: 0)
                            }
                            self.rewards.rewards.removeAll()
                            self.rewards.updateUpcomingReward()
                            self.partialSheetManager.closePartialSheet()
                        },
                        .default(Text("Cancel"))
                    ])
                }
                
                AboutView()
                    .frame(maxHeight: 70)
            }
            .frame(width: geo.size.width, height: geo.size.height)

//            .navigationBarTitle("")
//            .navigationBarHidden(true)
            .frame(height: geo.size.height)
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 30)
        .frame(height: 220)
        
    }
}

//struct OptionsModal_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionsModal(hideCompletedTasks)
//    }
//}
