//
//  EditRewardsModal.swift
//  Taska
//
//  Created by Andrew Nguyen on 6/5/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct EditRewardsModal: View {

    var rewards: Rewards

    var body: some View {
        
        GeometryReader { geo in
            VStack {
                Text("hello")
            ScrollView {
                List {
                    ForEach(self.rewards.rewards) { reward in
                        Text(reward.title)
                            .border(Color.green)
//                    .padding(-1)
                    }
                }
//                .transition(.opacity)
//                .animation(self.tasks.animated ? .default : .none)
                .buttonStyle(PlainButtonStyle())
                .environment(\.defaultMinListRowHeight, 10)
                .padding(10)
//                .frame(width: geo.size.width)
//                .frame(maxHeight: geo.size.height)
            }
//            .frame(width: geo.size.width, height: geo.size.height)
            .border(Color.red)
            }
        }
    }
}

struct EditRewardsModal_Previews: PreviewProvider {
    static var previews: some View {
        EditRewardsModal(rewards: Rewards())
    }
}
