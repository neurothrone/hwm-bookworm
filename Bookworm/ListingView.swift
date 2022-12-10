//
//  ListingView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

struct ListingView: View {
  @Environment(\.managedObjectContext) var moc
  @EnvironmentObject var dataController: DataController

  @AppStorage("id") var id: Int = 1

  @FetchRequest(sortDescriptors: [SortDescriptor(\.id)])
  var reviews: FetchedResults<Review>

  var body: some View {
    List(reviews, selection: $dataController.selectedReview) {
      Text($0.title)
        .tag($0)
        .contextMenu {
          Button("Delete", role: .destructive, action: deleteSelected)
        }
    }
    .onDeleteCommand(perform: deleteSelected)
    .toolbar {
      Button(action: addReview) {
        Label("Add Review", systemImage: "plus")
      }

      Button(role: .destructive, action: deleteSelected) {
        Label("Delete", systemImage: "trash")
      }
      .keyboardShortcut(.delete)
      .disabled(dataController.selectedReview == nil)
    }
  }
}

extension ListingView {
  private func addReview() {
    let review = Review(context: moc)
    review.id = Int32(id)
    review.title = "Enter the title"
    review.author = "Enter the author"
    review.rating = 3

    id += 1

    dataController.save()

    dataController.selectedReview = review
  }

  private func deleteSelected() {
    guard let selectedReview = dataController.selectedReview else {
      return
    }

    guard let selectedIndex = reviews.firstIndex(of: selectedReview) else { return }

    moc.delete(selectedReview)
    dataController.save()

    if selectedIndex < reviews.count {
      dataController.selectedReview = reviews[selectedIndex]
    } else {
      let previousIndex = selectedIndex - 1

      if previousIndex >= 0 {
        dataController.selectedReview = reviews[previousIndex]
      }
    }
  }
}

struct ListingView_Previews: PreviewProvider {
  static var previews: some View {
    ListingView()
  }
}
