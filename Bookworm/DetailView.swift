//
//  DetailView.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

enum Rating: Int32 {
  case one = 1,
       two = 2,
       three = 3,
       four = 4,
       five = 5
}

extension Rating: Identifiable, CaseIterable {
  var id: Self { self }
}

struct DetailView: View {
  @EnvironmentObject var dataController: DataController

  @ObservedObject var review: Review

  @State private var showingRendered = false

  var body: some View {
    content
      .onChange(of: review.title, perform: dataController.enqueueSave)
      .onChange(of: review.author, perform: dataController.enqueueSave)
      .onChange(of: review.text, perform: dataController.enqueueSave)
      .onChange(of: review.rating, perform: dataController.enqueueSave)
      .toolbar {
        Button(action: { showingRendered.toggle() }) {
          Label("Show rendered", systemImage: "book")
        }
      }
      .sheet(isPresented: $showingRendered) {
        RenderView(review: review)
      }
  }

  private var content: some View {
    Form {
      TextField("Title", text: $review.title)
      TextField("Author", text: $review.author)

      Picker("Rating", selection: $review.rating) {
        ForEach(Rating.allCases) { rating in
          Text(String(rating.rawValue))
            .tag(Int32(rating.rawValue))
        }
      }
      .pickerStyle(.segmented)

//      Picker("Rating", selection: $review.rating) {
//        ForEach(1..<6) {
//          Text(String($0))
//            .tag(Int32($0))
//        }
//      }
//      .pickerStyle(.segmented)

      TextEditor(text: $review.text)
    }
    .padding()
    // Once we delete the object the managedObjectContext will be nil
    .disabled(review.managedObjectContext == nil)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    let dataController = DataController()
    let review = Review(context: dataController.viewContext)

    DetailView(review: review)
      .environmentObject(dataController)
  }
}
