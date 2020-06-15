//
//  Colors.swift
//  esportstracker
//
//  Created by Andrew Nguyen on 4/28/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI

struct Colors: View {
    static let red0 = Color(red: 255/255, green: 94/255, blue: 94/255)
    static let red1 = Color(red: 235/255, green: 59/255, blue: 86/255)
    static let red2 = Color(red: 248/255, green: 120/255, blue: 132/255)
    static let red3 = Color(red: 212/255, green: 6/255, blue: 34/255)
    
    static let green0 = Color(red: 97/255, green: 228/255, blue: 137/255)
    static let green1 = Color(red: 61/255, green: 44/255, blue: 137/255)
    
    static let blue0 = Color(red: 28/255, green: 127/255, blue: 255/255)
    static let blue1 = Color(red: 0/255, green: 75/255, blue: 217/255)
    static let blue2 = Color(red: 86/255, green: 125/255, blue: 244/255)
    static let blue3 = Color(red: 242/255, green: 245/255, blue: 255/255)
    static let lightBlue0 = Color(red: 195/255, green: 211/255, blue: 247/255)
    static let darkBlue0 = Color(red: 30/255, green: 34/255, blue: 74/255)
    static let darkBlue1 = Color(red: 65/255, green: 71/255, blue: 112/255)
    
    static let yellow0 = Color(red: 255/255, green: 186/255, blue: 48/255)
    
    static let grey0 = Color(red: 240/255, green: 240/255, blue: 240/255)
    static let grey1 = Color(red: 238/255, green: 238/255, blue: 238/255)
    static let systemGray5 = Color(red: 44/255, green: 44/255, blue: 46/255)
    
    static let white0 = Color(red: 255/255, green: 255/255, blue: 255/255)
    
    static let redGradient = Gradient(colors: [Colors.red0, Colors.red1])
    static let blueGradient = Gradient(colors: [Colors.blue0, Colors.blue1])
    
    static let lightModeBackground = blue3
    static let darkModeBackground = Color.black
    
    static let lightModeDashboardBackground = blue2
    static let darkModeDashboardBackground = blue2
    
    static let lightModeTaskIncomplete = Color.white
    static let lightModeTaskCompleted = blue2
    
    static let darkModeTaskIncomplete = systemGray5
    static let darkModeTaskCompleted = blue2
    
    static let lightModeTaskRemove = red2
    static let darkModeTaskRemove = Color.red
    
    var body: some View {
        Text("Hello World!")
    }
}

struct Colors_Previews: PreviewProvider {
    static var previews: some View {
        Colors()
    }
}
