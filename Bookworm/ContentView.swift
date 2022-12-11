//
//  ContentView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var dataController: DataController

  var body: some View {
    NavigationSplitView {
      ReviewListView()
        .frame(minWidth: 250)
    } detail: {
      if let selectedReview = dataController.selectedReview {
        DetailView(review: selectedReview)
      } else {
        Text("Please select a review")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
