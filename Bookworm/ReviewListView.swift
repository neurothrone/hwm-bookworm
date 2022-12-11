//
//  ReviewListView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

enum ReviewSortType: String {
  case id = "Id",
       title = "Title",
       author = "Author",
       rating = "Rating"
}

extension ReviewSortType: Identifiable, CaseIterable {
  var id: Self { self }
}

struct ReviewListView: View {
  @Environment(\.managedObjectContext) var moc
  @EnvironmentObject var dataController: DataController

  @AppStorage("id") var id: Int = 1
  @AppStorage("reviewSortType") var reviewSort: ReviewSortType = .id

  @FetchRequest(
    sortDescriptors: [SortDescriptor(\.id)],
    animation: .default
  )
  var reviews: FetchedResults<Review>

  var body: some View {
    content
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

  private var content: some View {
    List(reviews, selection: $dataController.selectedReview) {
      ReviewListRowView(review: $0)
        .tag($0)
        .contextMenu {
          Button("Delete", role: .destructive, action: deleteSelected)
        }
    }
    .onDeleteCommand(perform: deleteSelected)
    .onChange(of: reviewSort) { _ in
//      let keyPath: KeyPath<Review, String>
//      let keyPath: ReferenceWritableKeyPath<Review, Any>

      let sortDescriptor: SortDescriptor<Review>

      switch reviewSort {
      case .id:
        sortDescriptor = SortDescriptor(\.id)
      case .title:
        sortDescriptor = SortDescriptor(\.title)
      case .author:
        sortDescriptor = SortDescriptor(\.author)
      case .rating:
        sortDescriptor = SortDescriptor(\.rating)
      }

      reviews.sortDescriptors = [sortDescriptor]
    }
  }
}

extension ReviewListView {
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

struct ReviewListView_Previews: PreviewProvider {
  static var previews: some View {
    ReviewListView()
  }
}
