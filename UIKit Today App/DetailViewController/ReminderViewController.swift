//
//  ReminderViewController.swift
//  UIKit Today App
//
//  Created by Katya Brylinska on 21.12.2023.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    
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
        

        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder vc title")
        
        updateSnapshot()
    }
    
    
    //should read more about Snapshot - do not really understand why we append all instances of Row
    func updateSnapshot(){
        var snapshot = Snapshot()
        snapshot.appendSections([.view]) //again what is going here ? to configure a snapshot if the controller is in view mode.
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
        // applying a snapshot updates the user interface to reflect the snapshot’s data and styling
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
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
