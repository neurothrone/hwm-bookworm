//
//  SettingsView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

struct SettingsView: View {
  @AppStorage("reviewSortType") var reviewSort: ReviewSortType = .id

  var body: some View {
    Form {
      Picker("Review Sort Type", selection: $reviewSort) {
        ForEach(ReviewSortType.allCases) {
          Text($0.rawValue)
        }
      }
      .pickerStyle(.segmented)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
