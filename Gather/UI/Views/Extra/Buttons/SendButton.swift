//
//  SendButton.swift
//  Gather
//
//  Created by Tyler Cagle on 9/29/20.
//

import SwiftUI

struct SendButton: View {
    @State var expanded = false
    
    var buttonPressed: () -> () = { }

    let buttonColor = Colors.sienna
    let size = Sizes.xLarge - Sizes.Spacer

    var body: some View {
        Image(systemName: "arrow.up.circle.fill")
            .resizable()
            .frame(width: size, height: size)
            .foregroundColor(buttonColor)
            .background(
                Color.white
                    .padding(Sizes.Spacer / 2)
                    .cornerRadius(Sizes.Large)
                    .overlay(
                        RoundedRectangle(cornerRadius: Sizes.Large)
                            .stroke(buttonColor, lineWidth: 2)
                    )
            )
            .padding(Sizes.xSmall)
            .contentShape(Rectangle())
            .scaleEffect(expanded ? 0.8 : 1.0)
            .onTapGesture {
                withAnimation(Animation.easeInOut(duration: Animation.animationQuick)) {
                    self.expandButton()
                }
                buttonPressed()
        }
    }
    
    func expandButton() {
        expanded.toggle()

        delayWithSeconds(Animation.animationIn) {
            withAnimation(Animation.easeInOut(duration: Animation.animationQuick)) {
                self.expanded.toggle()
            }
        }
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        SendButton()
    }
}
