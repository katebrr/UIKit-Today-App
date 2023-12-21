//
//  ReminderViewController.swift
//  UIKit Today App
//
//  Created by Katya Brylinska on 21.12.2023.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource!
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfig)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistraitonHandle)
        dataSource = DataSource(collectionView: collectionView)
        { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    func cellRegistraitonHandle(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row) //isn't it possible to attach style to the text property?
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }
}
