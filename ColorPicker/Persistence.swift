//
//  Persistence.swift
//  ColorPicker
//
//  Created by JunHyuk Lim on 22/12/2022.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let exampleColor = UIColor(Color(.sRGB, red: 0.4, green: 0.3, blue: 0))
        let colorCode = ColorViewModel().drawHexNumber
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.red = Float(exampleColor.components.red)
            newItem.blue = Float(exampleColor.components.blue)
            newItem.green = Float(exampleColor.components.green)
            newItem.alpha = Float(exampleColor.components.alpha)
            
            
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ColorPicker")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
