//
//  ContentView.swift
//  esportstracker
//
//  Created by Andrew Nguyen on 4/27/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: 350))
                        path.addLine(to: CGPoint(x: 414, y: 310))
                        path.addLine(to: CGPoint(x: 414, y: -44))
                    }
                    .fill(LinearGradient(gradient: Colors.redGradient, startPoint: .leading, endPoint: .trailing))
                    HStack {
                        VStack {
                            Text("taska")
                                .fontWeight(.bold)
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                                .padding(.bottom, 400)
                        }
                    }
                    Text("\"A goal without a plan is just a wish.\"")
                        .fontWeight(.semibold)
                    Text("Antoine de Saint-Exupéry")
                        .offset(y: 30)
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(LinearGradient(gradient: Colors.redGradient, startPoint: .leading, endPoint: .trailing))
                            .frame(width: 200, height: 70)
                        NavigationLink(destination: TasksView()) {
                            Text("Continue")
                                .fontWeight(.bold)
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                        }
                    }
                    .offset(y: 180)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
