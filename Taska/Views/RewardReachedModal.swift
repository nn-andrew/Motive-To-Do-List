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
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    @State var isAtMaxScale = false
    var giftScale: CGFloat = 1.06
    
    @State var title = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack() {
                    Text("Congratulations!")
                        .font(.system(size: 17, weight: .semibold))
                        .fontWeight(.semibold)
                        .frame(maxWidth: geo.size.width * 0.8)
                        .padding(.top, 20)
                    Text("You reached a reward:\n")
                        .font(.system(size: 16, weight: .regular))
//                    Spacer()
                    self.rewardTitle
                        .padding(.bottom, 30)
                        .frame(maxWidth: geo.size.width * 0.8)
                    Image("gift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0, height: 150)
                        .scaleEffect(self.isAtMaxScale ? self.giftScale : 1)
                        .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true))
                        .onAppear(perform: {
                            withAnimation {
                                self.isAtMaxScale.toggle()
                            }
                         })
                        .padding(.bottom, 40)
                    Button(action: {
                        print(self.rewards.rewards)
                        self.rewards.updateUpcomingReward()
                        self.rewards.upcomingReward = Reward()
                        self.partialSheetManager.closePartialSheet()
                    }) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 14)
//                                .frame(width: 100, height: 40)
//                                .fill(
                            Text("Continue")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .padding(10)
                                .foregroundColor(Color.white)
                                .background(Colors.yellow0)
                                .cornerRadius(12)
                                .padding(.bottom, 20)
//                                .padding(10)
//                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear(perform: {
            self.title = self.rewards.upcomingReward.title
            self.rewards.removeReward(index: 0)
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
