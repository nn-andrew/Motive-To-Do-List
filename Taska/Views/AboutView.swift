//
//  CreditsView.swift
//  Taska
//
//  Created by Andrew Nguyen on 6/2/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                Text("Copyright © 2020 Andrew N. All right reserved.")
                Text("Gift icon made by Freepik from www.flaticon.com")
            }
            .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
            .font(.system(size: 12))
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
