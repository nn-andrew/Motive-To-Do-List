//
//  RewardReachedModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import PartialSheet

struct RewardReachedModal: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    @State var isAtMaxScale = false
    var giftScale: CGFloat = 1.06
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack() {
                    Text("Congratulations!")
                        .fontWeight(.semibold)
                        .frame(maxWidth: geo.size.width * 0.8)
                        .padding(.top, 20)
                    Text("You reached a reward:\n")
//                    Spacer()
                    self.rewardTitle
                        .padding(.bottom, 30)
                        .frame(maxWidth: geo.size.width * 0.8)
                    Image("gift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0, height: 150)
                        .scaleEffect(self.isAtMaxScale ? self.giftScale : 1)
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                        .onAppear(perform: {
                            withAnimation() {
                                self.isAtMaxScale.toggle()
                            }
                         })
                        .padding(.bottom, 40)
                    Button(action: {
                        self.rewards.removeReward()
                        self.rewards.updateUpcomingReward()
//                        self.tasks.completedTasksForNextReward = 0
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
                                .background(Color.yellow)
                                .cornerRadius(12)
//                                .padding(10)
//                        }
                    }
                    Spacer()
                }
            }
//            .border(Color.red)
        }
    }
    
    @ViewBuilder
    var rewardTitle: some View {
        self.rewards.rewards.count > 0 ? self.rewards.rewards[0].title.font(.system(size: 20)) : Text("no reward title")
    }
}

struct RewardReachedModal_Previews: PreviewProvider {
    static var previews: some View {
        RewardReachedModal()
    }
}
