//
//  DashboardSubview.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/6/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet

struct DashboardSubview: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
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
    
    var textualInfo: some View {
        VStack {
            HStack {
                Text(String(self.weekdayDict[self.weekday] ?? "date error"))
                    .foregroundColor(.white)
                    .font(.custom("Rubik-Medium", size: 30))
                Spacer()
            }
            HStack {
                Text(String(Int(self.tasks.percentageCompleted * 100)))
                    .foregroundColor(.white)
                Text("%")
                    .offset(x: -6)
                    .foregroundColor(.white)
                Spacer()
            }
//            .padding(.bottom, -16)
        }
    }
    
    var progressBar: some View {
        GeometryReader { geo1 in
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.white)
                        .opacity(0.3)
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
