//
//  ReminderListViewController+DataSource.swift
//  UIKit Today App
//
//  Created by Katya Brylinska on 21.12.2023.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {

        let reminder = reminders[indexPath.item]
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = reminder.title
        contentConfig.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfig.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfig
        
        var doneButtonConfig = doneButtonConfiguration(for: reminder)
        
        doneButtonConfig.tintColor = .todayListCellDoneButtonTint
        
        cell.accessories = [.customView(configuration: doneButtonConfig),
                            .disclosureIndicator(displayed: .always)] // for little arrows on the right
        
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .todayDetailCellTint
        cell.backgroundConfiguration = backgroundConfig
    }
    
    //why not to filter, and then retrieve reminders.first, if possible can we guard let here?
    /*
      filteredReminders = reminders.filter { $0.id == id }
     return filteredReminders.first
     */
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }
    
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }
    
    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
//        print(reminder.isComplete)
        updateReminder(reminder)
    }
    
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
//        let symbolConfigHighlighted = UIImage.SymbolConfiguration(paletteColors: [UIColor.red])
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
//        let imageHighlited = UIImage(systemName: symbolName, withConfiguration: symbolConfigHighlighted)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
 //       button.isHighlighted = true
        button.setImage(image, for: .normal)
 //       button.setImage(imageHighlited, for: .highlighted)
        
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
