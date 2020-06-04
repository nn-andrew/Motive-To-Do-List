//
//  CreditsView.swift
//  Taska
//
//  Created by Andrew Nguyen on 6/2/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                Text("Developed by Andrew Nguyen")
                Text("Gift icon made by Freepik from www.flaticon.com")
                Spacer()
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
