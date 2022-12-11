//
//  RatingView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

struct RatingView: View {
  let reviewRating: Int
  
  var body: some View {
    HStack {
      ForEach(Rating.allCases) { rating in
        Image(systemName: "star.fill")
          .foregroundColor(
            rating.rawValue > reviewRating
            ? .gray
            : .yellow
          )
      }
    }
  }
}

struct RatingView_Previews: PreviewProvider {
  static var previews: some View {
    RatingView(reviewRating: 3)
  }
}
