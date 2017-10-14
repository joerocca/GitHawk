//
//  SearchRecentCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SearchRecentCell: SelectableCell {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        
        contentView.addSubview(label)

        label.textColor = Styles.Colors.Gray.dark.color
        label.font = Styles.Fonts.body
        label.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(safeAreaLayoutGuide)
                make.right.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-Styles.Sizes.gutter)
                make.left.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.gutter)
            } else {
                make.centerY.equalTo(contentView)
                make.right.lessThanOrEqualTo(contentView).offset(-Styles.Sizes.gutter)
                make.left.equalTo(contentView).offset(Styles.Sizes.gutter)
            }
        }

        addBorder(.bottom, left: Styles.Sizes.gutter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ text: String) {
        label.text = text
    }

}
