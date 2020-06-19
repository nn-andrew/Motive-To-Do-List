//
//  RewardReachedModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import PartialSheet

struct RewardReachedModal: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    @State var isAtMaxScale = false
    var giftScale: CGFloat = 1.1
    
    @State var title = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack() {
                    Text("Congratulations!")
                        .font(.system(size: 17, weight: .semibold))
                        .fontWeight(.semibold)
                        .frame(maxWidth: geo.size.width * 0.8)
//                        .padding(.top, 30)
                    Text("You reached a reward:\n")
                        .font(.system(size: 16, weight: .regular))
                    self.rewardTitle
                        .frame(maxWidth: geo.size.width * 0.8, maxHeight: 60, alignment: .top)
//                        .padding(.top, -30)
                }
                .position(x: geo.size.width * 0.5, y: geo.size.height * 0.15)
                
                ZStack {
                    Image("gift background")
                        .resizable()
                        .scaledToFit()
                        .opacity(self.colorScheme == .light ? 0.6 : 1)
                        .frame(width: geo.size.width * 0.9)
                        .padding(.bottom, 40)
                    Image("gift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.42)
                        .scaleEffect(self.isAtMaxScale ? self.giftScale : 1)
                        .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true))
                        .onAppear(perform: {
                            withAnimation {
                                self.isAtMaxScale.toggle()
                            }
                         })
                        .padding(.bottom, 40)
                }
                .position(x: geo.size.width * 0.5, y: geo.size.height * 0.6)
                
                Button(action: {
                    self.rewards.updateUpcomingReward()
//                        self.rewards.upcomingReward = Reward()
                    self.partialSheetManager.closePartialSheet()
                }) {
                    Text("Continue")
//                        .font(.custom("Rubik-Medium", size: 20))
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .padding([.top, .bottom], 15)
                        .padding([.leading, .trailing], 90)
                        .foregroundColor(Color.white)
                        .background(Colors.yellow0)
                        .cornerRadius(7)
                }
                .position(x: geo.size.width * 0.5, y: geo.size.height * 0.95)
            }
        }
        .padding(20)
        .onAppear(perform: {
            self.title = self.rewards.upcomingReward.title
//            self.rewards.removeReward(index: 0)
        })
        .onDisappear(perform: {
            if self.rewards.rewards.count > 0 {
                self.rewards.removeReward(index: 0)
                self.rewards.updateUpcomingReward()
            }
        })
    }
    
    @ViewBuilder
    var rewardTitle: some View {
        Text(self.title)
            .font(.system(size: 20, weight: .regular))
    }
}

struct RewardReachedModal_Previews: PreviewProvider {
    static var previews: some View {
        RewardReachedModal()
    }
}
