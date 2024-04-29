//
//  AppBackgroundView.swift
//  Questify
//
//  Created by Telem Tobi on 26/04/2024.
//

import SwiftUI

struct AppBackgroundView: View {
    @State var degreesRotating = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            let viewSize = CGSize(
                width: geometry.size.width,
                height: geometry.size.height
            )
            
            ZStack {
                ForEach(0..<5, id: \.self) { index in
                    let randomSize = CGFloat.random(in: 1000...1500)
                    let randomX = CGFloat.random(in: (viewSize.width * -0.5)...(viewSize.width * 1.5))
                    let randomY = CGFloat.random(in: (viewSize.height * -0.5)...(viewSize.height * 1.5))
                    let randomOpacity = randomSize.progress(in: 1000...1500)

                    (index % 4 == 0 ? Color.pink : Color.blue)
                        .frame(width: randomSize, height: randomSize)
                        .clipShape(.circle)
                        .position(x: randomX, y: randomY)
                        .opacity(randomOpacity)
                        .zIndex(randomSize / 100)
                }
            }
            .blur(radius: 80)
            .frame(width: viewSize.width, height: viewSize.height)
            .rotationEffect(.degrees(degreesRotating))
        }
//            .overlay(.ultraThinMaterial)
        .onAppear {
            withAnimation(.linear(duration: 10).speed(0.2).repeatForever(autoreverses: false)) {
                degreesRotating = 360
            }
        }
    }
}

#Preview {
    AppBackgroundView()
}
