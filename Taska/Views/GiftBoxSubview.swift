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
            layer0
            layer2
        }
    }
    
    var layer0: some View {
        Rectangle()
        .fill(Color.white)
        .opacity(0.25)
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

    }

    var layer1: some View {
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
            maskShape
        )
    }
    
    var layer2: some View {
        ZStack() {
            HStack {
                Spacer()
                Capsule()
                    .rotation(Angle(degrees: 26.0))
                    .fill(Colors.red1)
                    .frame(width: 30, height: 20)
                    .padding(-10)
                Capsule()
                    .rotation(Angle(degrees: -26.0))
                    .fill(Colors.red1)
                    .frame(width: 30, height: 20)
                    .padding(-10)
                Spacer()
            }
            .offset(y: -32)

            VStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Colors.white0)
                    .frame(width: 86, height: 24)
                    .offset(y: -18)
            }
            VStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Colors.white0)
                    .frame(width: 70, height: 70)
                    .offset(y: 5)
            }
            
//            VStack {
//                RoundedRectangle(cornerRadius: 6)
//                    .fill(Colors.red1)
//                    .frame(width: 23, height: 28)
//                    .offset(y: -18)
//            }
            VStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Colors.red1)
                    .frame(width: 20, height: 70)
                    .offset(y: 5)
            }
        }
        .frame(height: 100)
        .mask(
            maskShape
        )
    }
    
    var maskShape: some View {
        Rectangle()
            .border(Color.white)
            .offset(y: self.rewards.rewards.count > 0 ? 100 - (CGFloat(Double(self.rewards.upcomingReward.completedTasks) / Double(max(self.rewards.upcomingReward.completedTasksNeeded, 1)))) * 100 : 100)
            .animation(.default)
    }
}

struct GiftBoxSubview_Previews: PreviewProvider {
    static var previews: some View {
        GiftBoxSubview()
    }
}
