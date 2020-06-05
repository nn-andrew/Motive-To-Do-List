//
//  HostingController.swift
//  Taska
//
//  Created by Andrew Nguyen on 6/4/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
