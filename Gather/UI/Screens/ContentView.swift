//
//  ContentView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TaskListView()
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
