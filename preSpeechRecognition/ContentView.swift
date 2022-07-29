//
//  ContentView.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2022/07/29.
//

import SwiftUI
import Speech

struct ContentView: View {
    
    @State var button01Text = "record"
    @State var button01Color: Color = .blue
    @State var button02Text = "stop"
    @State var button02Color: Color = .blue

    @State var speachText = "-"
    
    
    
    var body: some View {
        VStack {
            Spacer()
            Text(speachText)
            Spacer()
            Button(
                action: {
                    button01Text = "recording..."
                    button01Color = .red
                },
                label: {
                    Text(button01Text)
                        .font(.largeTitle)
                        .foregroundColor(button01Color)
                }
            )
            Spacer()
                .frame(height: 50)
            Button(
                action: {
                    button01Text = "record"
                    button01Color = .blue
                },
                label: {
                    Text(button02Text)
                        .font(.largeTitle)
                        .foregroundColor(button02Color)
                }
            )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
