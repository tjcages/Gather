//
//  IconView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/8/20.
//

import SwiftUI

struct IconView: View {
    @Binding var emojiIcon: String
    @State private var selectingIcon = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if !selectingIcon {
                Image(systemName: "smiley.fill")
                    .resizable()
                    .frame(width: Sizes.xSmall, height: Sizes.xSmall)
                    .foregroundColor(Colors.subheadline)
                    .padding([.top, .leading, .bottom], Sizes.Spacer)

                Text("Add icon")
                    .customFont(.heavy, category: .small)
                    .foregroundColor(Colors.subheadline)
                    .padding([.top, .trailing, .bottom], Sizes.Spacer)

            } else {
                EmojiTextView(emojiText: $emojiIcon, font: uiFont(.heavy, category: .extraLarge), onDone: {
                        selectingIcon = false
                    })
                    .frame(width: Sizes.Large + Sizes.Spacer, height: Sizes.Large + Sizes.Spacer)
                    .padding(.trailing, Sizes.Spacer)
                    .offset(x: -4, y: 0)
            }
        }
            .background(Colors.subheadline.opacity(selectingIcon ? 0 : 0.1))
            .cornerRadius(Sizes.Spacer / 2)
            .padding(.bottom, selectingIcon ? 0 : Sizes.xSmall/2)
            .onTapGesture {
                selectingIcon = true
            }
            .onDisappear {
                selectingIcon = false
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(emojiIcon: .constant("1"))
    }
}
