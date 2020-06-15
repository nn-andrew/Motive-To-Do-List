//
//  DashboardSubview.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/6/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import PartialSheet

struct DashboardSubview: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    
//    let date = Date()
    let weekday = Calendar.current.component(.weekday, from: Date())
    let weekdayDict = [1: "sunday",
                       2: "monday",
                       3: "tuesday",
                       4: "wednesday",
                       5: "thursday",
                       6: "friday",
                       7: "saturday"]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 6) {
                    HStack {
                        Spacer()
                    }
                    
                    HStack {
                        self.textualInfo
                        
                        GiftBoxSubview()
                            .frame(width: 100)
                    }
                    
                    self.progressBar
                }
                .frame(maxWidth: geo.size.width - 100, maxHeight: 40)
//                .offset(y: 40)
            }
            .frame(width: geo.size.width, height: 40)
        }
    }
    
    @ViewBuilder
    var textualInfo: some View {
        VStack(spacing: 4) {
            HStack {
                Text(String(self.weekdayDict[self.weekday] ?? "date error"))
                    .foregroundColor(.white)
                    .font(.custom("Rubik-Medium", size: 34))
                Spacer()
            }
            HStack {
                if self.rewards.rewards.count > 0 {
                    Text(String("\(self.rewards.upcomingReward.completedTasks)/\(self.rewards.upcomingReward.completedTasksNeeded): \(self.rewards.upcomingReward.title)"))
                        .foregroundColor(.white)
                        .font(.custom("Rubik-Medium", size: 17))
                } else {
                    Text(String(Int(self.tasks.percentageCompleted * 100)))
                        .foregroundColor(.white)
                        .font(.custom("Rubik-Medium", size: 20))
                    Text("%")
                        .offset(x: -6)
                        .foregroundColor(.white)
                        .font(.custom("Rubik-Medium", size: 20))
                }
                Spacer()
            }
//            .frame(height: 45)
        }
        .frame(height: 60)
    }
    
    var progressBar: some View {
        GeometryReader { geo1 in
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.white)
                        .opacity(0.25)
                        .frame(width: CGFloat(Int(geo1.size.width)), height: 7)
                    Spacer()
                }

                HStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.white)
                        .frame(width: CGFloat(Int(geo1.size.width * CGFloat(self.tasks.percentageCompleted))), height: 7)
                        .animation(.default)
                    Spacer()
                }
            }
        }
//        .frame(height: 30)
        //.offset(y: -20)
    }
}

struct DashboardSubview_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSubview()
    }
}
