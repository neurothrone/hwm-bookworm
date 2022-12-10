//
//  RenderView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

struct RenderView: View {
  @Environment(\.dismiss) var dismiss

  let review: Review

  var body: some View {
    VStack(spacing: 10) {
      Text(review.title)
        .font(.system(.largeTitle, design: .serif))

      Text("by \(review.author)")
        .font(.system(.title, design: .serif))
        .italic()

      HStack {
        ForEach(Rating.allCases) { rating in
          Image(systemName: "star.fill")
            .foregroundColor(
              rating.rawValue > review.rating
              ? .gray
              : .yellow
            )
        }
      }

      ScrollView {
        Text(review.text)
          .fontDesign(.serif)
          .padding(.vertical)
      }

      Spacer()
        .frame(height: 50)

      Button("Done") {
        dismiss()
      }
    }
    .frame(maxWidth: 800)
    .padding(25)
  }
}

struct RenderView_Previews: PreviewProvider {
  static var previews: some View {
    let dataController = DataController()
    let review = Review(context: dataController.viewContext)

    RenderView(review: review)
  }
}
