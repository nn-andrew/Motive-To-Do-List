//
//  GiftBoxSubview.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct GiftBoxSubview: View {
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .opacity(0.3)
                .frame(width: 100, height: 100)
                .mask(
                    ZStack() {
                        HStack {
                            Spacer()
                            Capsule()
                                .rotation(Angle(degrees: 26.0))
                                .fill(Color.red)
                                .frame(width: 30, height: 20)
                                .padding(-10)
                            Capsule()
                                .rotation(Angle(degrees: -26.0))
                                .fill(Color.red)
                                .frame(width: 30, height: 20)
                                .padding(-10)
                            Spacer()
                        }
                        .offset(y: -32)
                        
                        VStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.red)
                                .frame(width: 86, height: 24)
                                .offset(y: 20)
                            Spacer()
                        }
                        VStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.red)
                                .frame(width: 70, height: 70)
                                .offset(y: 20)
                            Spacer()
                        }
                    }
                )
    //            .border(Color.red)
//            Rectangle()
//            .fill(Color.white)
//            .frame(width: 100, height: 100)
//            .mask(
                ZStack() {
                    HStack {
                        Spacer()
                        Capsule()
                            .rotation(Angle(degrees: 26.0))
                            .fill(Color.white)
                            .frame(width: 30, height: 20)
                            .padding(-10)
                        Capsule()
                            .rotation(Angle(degrees: -26.0))
                            .fill(Color.white)
                            .frame(width: 30, height: 20)
                            .padding(-10)
                        Spacer()
                    }
                    .offset(y: -32)
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white)
                            .frame(width: 86, height: 24)
                            .offset(y: -18)
                    }
                    VStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white)
                            .frame(width: 70, height: 70)
                            .offset(y: 5)
                    }
                }
                .frame(height: 100)
                .mask(
                    Rectangle()
                        .border(Color.white)
                        .offset(y: max(CGFloat(90 - ((Double(self.tasks.completedTasks.count) / Double(self.rewards.lowestRequiredCompletedTaskCount())) * 90)), 0))
                        .animation(.default)
                )
//            )
        }
    }
}

struct GiftBoxSubview_Previews: PreviewProvider {
    static var previews: some View {
        GiftBoxSubview()
    }
}
