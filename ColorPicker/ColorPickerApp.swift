//
//  ColorPickerApp.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 22/12/2022.
//

import SwiftUI

@main
struct ColorPickerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
