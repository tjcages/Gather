//
//  DurationView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/9/20.
//

import SwiftUI

struct DurationView: View {
    @State private var postDate = Date()

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(height: 200)
                .frame(maxWidth: .infinity)

            Text("Hello")

            Text("World")
            
            Spacer()
                .frame(height: Sizes.Big)
        }
            .padding(.top, Sizes.xSmall)
            .padding(.horizontal, Sizes.Default)
            .background(
                Colors.cellBackground
                    .cornerRadius(Sizes.Spacer)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                }
            )
    }
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView()
    }
}
