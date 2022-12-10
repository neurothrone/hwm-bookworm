//
//  DataController.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import CoreData
import Foundation

final class DataController: ObservableObject {
  @Published var selectedReview: Review?

  private let container: NSPersistentContainer = .init(name: "Entities")
  private var saveTask: Task<Void, Error>?

  var viewContext: NSManagedObjectContext { container.viewContext }

  init() {
    container.loadPersistentStores { description, error in
      if let error {
        print("❌ -> Core Data failed to load. Error: \(error.localizedDescription)")
      }
    }
  }
}

extension DataController {
  func save() {
    guard viewContext.hasChanges else { return }

    do {
      try viewContext.save()
    } catch {
      print("❌ -> Core Data failed to save changes. Error: \(error.localizedDescription)")
    }
  }

  func enqueueSave(_ change: Any) {
    saveTask?.cancel()

    saveTask = Task { @MainActor in
      try await Task.sleep(for: .seconds(5))
      save()
    }
  }
}
