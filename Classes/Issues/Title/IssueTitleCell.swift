//
//  IssueTitleCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueTitleCell: UICollectionViewCell {

    static let inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        
        label.numberOfLines = 0
        label.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(safeAreaLayoutGuide).inset(IssueTitleCell.inset)
            } else {
                make.edges.equalTo(contentView).inset(IssueTitleCell.inset)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
