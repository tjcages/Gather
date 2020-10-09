//
//  ScheduleItemView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/8/20.
//

import SwiftUI

struct ScheduleItemView: View {
    @State private var postDate = Date()

    var body: some View {
        VStack {
            DatePicker(selection: $postDate, in: Date()..., displayedComponents: .date) {
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Sizes.Default, height: Sizes.Default)
                    .foregroundColor(Colors.orange)
                    .colorMultiply(Colors.orange)
            }
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(.top, Sizes.Small)

            Text("Hello")

            Text("World")

            Text("Hello")

            Text("World")
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

struct ScheduleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleItemView()
    }
}
