//
//  SearchRecentHeaderCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchRecentHeaderCellDelegate: class {
    func didSelectClear(cell: SearchRecentHeaderCell)
}

final class SearchRecentHeaderCell: UICollectionViewCell {

    weak var delegate: SearchRecentHeaderCellDelegate? = nil

    private let label = UILabel()
    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        contentView.addSubview(button)

        label.text = NSLocalizedString("Recent Searches", comment: "").uppercased(with: Locale.current)
        label.font = Styles.Fonts.secondary
        label.textColor = Styles.Colors.Gray.light.color
        label.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(safeAreaLayoutGuide)
                make.left.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.gutter)
            } else {
                make.centerY.equalTo(contentView)
                make.left.equalTo(contentView).offset(Styles.Sizes.gutter)
            }
        }

        button.setTitle(NSLocalizedString("Clear", comment: ""), for: .normal)
        button.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)
        button.titleLabel?.font = Styles.Fonts.button
        button.addTarget(self, action: #selector(SearchRecentHeaderCell.onClear), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            if #available(iOS 11.0, *) {
                make.right.equalTo(safeAreaLayoutGuide).offset(-Styles.Sizes.gutter)
            } else {
                make.right.equalTo(contentView).offset(-Styles.Sizes.gutter)
            }
        }

        addBorder(.bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private API

    @objc
    func onClear() {
        delegate?.didSelectClear(cell: self)
    }

}
