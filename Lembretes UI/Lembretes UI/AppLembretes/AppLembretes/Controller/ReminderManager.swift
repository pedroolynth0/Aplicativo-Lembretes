//
//  RecipeManager.swift
//  Kiwi
//
//  Created by dti digital on 14/02/24.
//

import Foundation


struct ReminderManager {
    private static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let archiveURL = documentsDirectory.appendingPathComponent("lembretes").appendingPathExtension("plist")

    static func saveRecipe(_ lembrete: Reminder) {
        var existingReminders = loadReminder()
        existingReminders.append(lembrete)
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(existingReminders)
            try data.write(to: archiveURL, options: .noFileProtection)
        } catch {
            print("Error saving recipe: \(error)")
        }
    }

    static func deleteRecipe(_ lembreteID: String) {
        var existingReminder = loadReminder()
        existingReminder.removeAll { $0._id == lembreteID }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(existingReminder)
            try data.write(to: archiveURL, options: .noFileProtection)
        } catch {
            print("Error deleting recipe: \(error)")
        }
    }

    static func loadReminder() -> [Reminder] {
        do {
            let data = try Data(contentsOf: archiveURL)
            let decoder = PropertyListDecoder()
            return try decoder.decode([Reminder].self, from: data)
        } catch {
            print("Error loading recipes: \(error)")
            return []
        }
    }
    
    static func updateReminder(_ updatedLembrete: Reminder) {
         var existingReminders = loadReminder()
         
         if let index = existingReminders.firstIndex(where: { $0._id == updatedLembrete._id }) {
             existingReminders[index] = updatedLembrete
         } else {
             print("Reminder not found.")
             return
         }

         do {
             let encoder = PropertyListEncoder()
             let data = try encoder.encode(existingReminders)
             try data.write(to: archiveURL, options: .noFileProtection)
         } catch {
             print("Error updating recipe: \(error)")
         }
     }
}



