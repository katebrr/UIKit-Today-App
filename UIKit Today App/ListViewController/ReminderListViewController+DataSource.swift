//
//  ReminderListViewController+DataSource.swift
//  UIKit Today App
//
//  Created by Katya Brylinska on 21.12.2023.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String){
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = reminder.title
        contentConfig.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfig.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfig
    }
}
