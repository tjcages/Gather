//
//  ContentHeaderView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/14/20.
//

import SwiftUI

struct ContentHeaderView: View {
    let height: CGFloat = 3
    let width: CGFloat = Sizes.Default

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button(action: {
                    // Menu button action
                }, label: {
                        VStack(alignment: .leading, spacing: Sizes.Spacer / 2) {
                            RoundedRectangle(cornerRadius: 3 / 2)
                                .foregroundColor(Colors.backgroundInvert)
                                .frame(width: width - Sizes.Spacer, height: height, alignment: .leading)
                                .padding(.leading, Sizes.Spacer)

                            RoundedRectangle(cornerRadius: 3 / 2)
                                .foregroundColor(Colors.backgroundInvert)
                                .frame(width: width, height: height, alignment: .leading)

                            RoundedRectangle(cornerRadius: 3 / 2)
                                .foregroundColor(Colors.backgroundInvert)
                                .frame(width: width - Sizes.Spacer, height: height, alignment: .leading)
                        }
                    }
                )

                Spacer()

                Button(action: {

                }, label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Sizes.Small, height: Sizes.Small)
                            .foregroundColor(Colors.backgroundInvert)
                    }
                )
            }
                .padding(.horizontal, Sizes.Small)
                .padding(.bottom, Sizes.Default)
                .padding(.top, Sizes.xSmall)

            CalendarHeaderView()
                .padding(.bottom, Sizes.Spacer)

            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Colors.backgroundInvert)
                .opacity(0.3)
        }
    }
}

struct ContentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentHeaderView()
    }
}
