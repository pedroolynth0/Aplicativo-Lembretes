//
//  ModelLembrete.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 18/07/23.
//

import Foundation

//MARK: REQUEST
class ViewModel: ObservableObject {
    @Published var chars: [Reminder] = []
    
    init() {
    }
    
    func groupLembretesByDate() -> OrderedDictionary<String, [Reminder]> {
        var groupedLembretes: OrderedDictionary<String, [Reminder]> = OrderedDictionary()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"

        for lembrete in chars {
            if let date = dateFormatter.date(from: lembrete.data) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day], from: date)
                let formattedDate = "\(components.day!)/\(components.month!)/\(components.year!)"

                if var lembretesArray = groupedLembretes[formattedDate] {
                    lembretesArray.append(lembrete)
                    groupedLembretes[formattedDate] = lembretesArray
                } else {
                    groupedLembretes[formattedDate] = [lembrete]
                }
            }
        }
        return groupedLembretes
    }
    
    func getData() {
        chars = ReminderManager.loadReminder()
    }
    
    func delete(_ lembreteID: String) {
        ReminderManager.deleteRecipe(lembreteID)
        getData()
    }
    
    func update(_ reminder: Reminder) {
        ReminderManager.updateReminder(reminder)
        getData()
    }
}
