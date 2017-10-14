//
//  SegmentedControlCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol SegmentedControlCellDelegate: class {
    func didChangeSelection(cell: SegmentedControlCell, index: Int)
}

final class SegmentedControlCell: UICollectionViewCell {

    weak var delegate: SegmentedControlCellDelegate? = nil

    private let segmentedControl = UISegmentedControl(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        
        contentView.addSubview(segmentedControl)

        segmentedControl.addTarget(self, action: #selector(SegmentedControlCell.didSelect(sender:)), for: .valueChanged)
        segmentedControl.tintColor = Styles.Colors.Blue.medium.color
        segmentedControl.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(safeAreaLayoutGuide)
                make.left.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.gutter)
                make.right.equalTo(safeAreaLayoutGuide).offset(-Styles.Sizes.gutter)
            } else {
                make.centerY.equalTo(contentView)
                make.left.equalTo(contentView).offset(Styles.Sizes.gutter)
                make.right.equalTo(contentView).offset(-Styles.Sizes.gutter)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(items: [String], selectedIndex: Int) {
        segmentedControl.removeAllSegments()
        for (i, item) in items.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: i, animated: false)
        }
        segmentedControl.selectedSegmentIndex = selectedIndex
    }

    // MARK: Private API

    @objc private func didSelect(sender: Any) {
        delegate?.didChangeSelection(cell: self, index: segmentedControl.selectedSegmentIndex)
    }
    
}
