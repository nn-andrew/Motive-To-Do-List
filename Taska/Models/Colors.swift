//
//  Colors.swift
//  esportstracker
//
//  Created by Andrew Nguyen on 4/28/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct Colors: View {
    static let red0 = Color(red: 255/255, green: 94/255, blue: 94/255)
    static let red1 = Color(red: 235/255, green: 59/255, blue: 86/255)
    static let red2 = Color(red: 248/255, green: 120/255, blue: 132/255)
    
    static let green0 = Color(red: 97/255, green: 228/255, blue: 137/255)
    static let green1 = Color(red: 61/255, green: 44/255, blue: 137/255)
    
    static let blue0 = Color(red: 28/255, green: 127/255, blue: 255/255)
    static let blue1 = Color(red: 0/255, green: 75/255, blue: 217/255)
    static let blue2 = Color(red: 86/255, green: 125/255, blue: 244/255)
    
    static let grey0 = Color(red: 240/255, green: 240/255, blue: 240/255)
    static let grey1 = Color(red: 230/255, green: 230/255, blue: 230/255)
    
    static let white0 = Color(red: 255/255, green: 255/255, blue: 255/255)
    
    static let redGradient = Gradient(colors: [Colors.red0, Colors.red1])
    static let blueGradient = Gradient(colors: [Colors.blue0, Colors.blue1])
    
    var body: some View {
        Text("Hello World!")
    }
}

struct Colors_Previews: PreviewProvider {
    static var previews: some View {
        Colors()
    }
}
