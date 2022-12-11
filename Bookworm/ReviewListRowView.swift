//
//  ReviewListRowView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

struct ReviewListRowView: View {
  let review: Review
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(review.title)
      RatingView(reviewRating: Int(review.rating))
    }
  }
}

struct ReviewListRowView_Previews: PreviewProvider {
  static var previews: some View {
    let dataController = DataController()
    let review = Review(context: dataController.viewContext)
    review.title = "Dune"
    review.rating = 4

    return ReviewListRowView(review: review)
  }
}
