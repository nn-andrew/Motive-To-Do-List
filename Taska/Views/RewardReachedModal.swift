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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack() {
                    Text("Congratulations! You reached a reward:\n")
//                    Spacer()
                    self.rewardTitle
                    Spacer()
                }
            }
            .frame(height: geo.size.height * 0.9)
//            .border(Color.red)
        }
    }
    
    @ViewBuilder
    var rewardTitle: some View {
        self.rewards.rewards.count > 0 ? self.rewards.rewards[0].title : Text("empty rewards list")
    }
}

struct RewardReachedModal_Previews: PreviewProvider {
    static var previews: some View {
        RewardReachedModal()
    }
}
