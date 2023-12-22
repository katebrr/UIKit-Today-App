//
//  ReminderViewController+CellConfiguration.swift
//  UIKit Today App
//
//  Created by Kateryna BRYLINSKA on 22/12/2023.
//

import UIKit

extension ReminderViewController {
    
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row)  -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row) //isn't it possible to attach style to the text property?
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String)  -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Config {
        var contentConfig = cell.textFieldConfiguration()
        contentConfig.text = title
        return contentConfig
    }
    
    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Config {
        var contentConfig = cell.datePickerConfiguration()
        contentConfig.date = date
        return contentConfig
    }
    
    func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Config {
        var contentConfig = cell.textViewConfiguration()
        contentConfig.text = notes
        return contentConfig
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default: return nil
        }
    }
    
}
