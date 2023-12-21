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
        
        var doneButtonConfig = doneButtonConfiguration(for: reminder)
        
        doneButtonConfig.tintColor =  .todayListCellDoneButtonTint
        
        cell.accessories = [.customView(configuration: doneButtonConfig),
                            .disclosureIndicator(displayed: .always)] // for little arrows on the right
        
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .todayDetailCellTint
        cell.backgroundConfiguration = backgroundConfig
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
//        let symbolConfigHighlighted = UIImage.SymbolConfiguration(paletteColors: [UIColor.red])
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
//        let imageHighlited = UIImage(systemName: symbolName, withConfiguration: symbolConfigHighlighted)
        let button = UIButton()
 //       button.isHighlighted = true
        button.setImage(image, for: .normal)
 //       button.setImage(imageHighlited, for: .highlighted)
        
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
