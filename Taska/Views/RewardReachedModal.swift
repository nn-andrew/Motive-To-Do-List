//
//  RewardReachedModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/7/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct RewardReachedModal: View {
    @EnvironmentObject var tasks: Tasks
    @EnvironmentObject var rewards: Rewards
    @State var giftScale: CGFloat = 1
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack() {
                    Text("Congratulations!")
                        .fontWeight(.semibold)
                    Text("You reached a reward:\n")
//                    Spacer()
                    self.rewardTitle
                    Spacer()
                    Image("gift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0, height: 150)
//                        .animation(.spring())
                        .scaleEffect(self.giftScale)
                        .animation(Animation.easeOut)
                    Spacer()
                }
            }
//            .border(Color.red)
        }
    }
    
    @ViewBuilder
    var rewardTitle: some View {
        self.rewards.rewards.count > 0 ? self.rewards.rewards[0].title : Text("no reward title")
    }
}

struct RewardReachedModal_Previews: PreviewProvider {
    static var previews: some View {
        RewardReachedModal()
    }
}
