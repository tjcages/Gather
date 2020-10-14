//
//  GreetingView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import SwiftUI

struct GreetingView: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            Text(dateFormatter.string(from: Date()))
                .customFont(.heavy, category: .extraLarge)
                .foregroundColor(Colors.headline)
                .multilineTextAlignment(.leading)

            Text("Good morning")
                .customFont(.heavy, category: .large)
                .foregroundColor(Colors.subheadline)
                .multilineTextAlignment(.leading)
        }
            .frame(height: 92)
            .padding(.horizontal, Sizes.Default)
            .padding(.bottom, Sizes.xSmall)
            .padding(.top, Sizes.Spacer)
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
