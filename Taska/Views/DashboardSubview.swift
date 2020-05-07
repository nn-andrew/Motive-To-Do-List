//
//  DashboardSubview.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/6/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI

struct DashboardSubview: View {
    @EnvironmentObject var tasks: Tasks
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                    VStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text("monday")
                                        .foregroundColor(.white)
                                        .font(.custom("Rubik-Medium", size: 30))
                                    Spacer()
                                }
                                HStack {
                                    Text(String(Int(self.tasks.percentageCompleted * 100)))
                                        .foregroundColor(.white)
                                    Text("%")
                                        .offset(x: -6)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding(.bottom, -16)
                            }
//                            .border(Color.white)
                            
                            // Gift box
                            GiftBoxSubview()
                        }
                        
                        // Progress bar
                        GeometryReader { geo1 in
                            ZStack {
                                HStack {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.white)
                                        .opacity(0.3)
                                        .frame(width: CGFloat(Int(geo1.size.width)), height: 7)
                                        .padding(.bottom, 36)
                                    Spacer()
                                }
    
                                HStack {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.white)
                                        .frame(width: CGFloat(Int(geo1.size.width * CGFloat(self.tasks.percentageCompleted))), height: 7)
                                        .animation(.default)
                                        .padding(.bottom, 36)
                                    Spacer()
                                }
                            }
                        }
                        .frame(height: 50)
                        .padding(.bottom, -20)
//                        .border(Color.green)
                    }
                    .frame(maxWidth: geo.size.width - 100, maxHeight: 100)
                    .offset(y: 30)
//                    .border(Color.red)
                
                    //.border(Color.red)
                    
//                    VStack {
//                        Spacer()
//                        Spacer()
//                        Circle()
//                            .stroke(Color.white, lineWidth: 4)
//                            .frame(width: 120)
//                            .border(Color.green)
//                    }

            }
            .frame(width: geo.size.width+1, height: 200)
            .background(LinearGradient(gradient: Colors.blueGradient, startPoint: .leading, endPoint: .trailing))
            .opacity(0.9)
        }
    }
}

struct DashboardSubview_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSubview()
    }
}
