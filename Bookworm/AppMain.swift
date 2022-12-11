//
//  AppMain.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//

import SwiftUI

@main
struct AppMain: App {
  @StateObject private var dataController: DataController = .init()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(dataController)
        .environment(\.managedObjectContext, dataController.viewContext)
        .onReceive(NotificationCenter.default.publisher(
          for: NSApplication.willTerminateNotification)
        ) { _ in
          dataController.save()
        }
    }

    Settings(content: SettingsView.init)
  }
}
