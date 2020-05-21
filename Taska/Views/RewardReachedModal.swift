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
                    self.rewards.completedRewards[0].title
                    Spacer()
                }
            }
            .frame(height: geo.size.height * 0.9)
//            .border(Color.red)
        }
    }
}

struct RewardReachedModal_Previews: PreviewProvider {
    static var previews: some View {
        RewardReachedModal()
    }
}
