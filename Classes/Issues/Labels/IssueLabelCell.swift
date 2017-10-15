//
//  IssueLabelCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueLabelCell: UICollectionViewCell, ListBindable {

    let background = UIView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(background)
        background.addSubview(label)

        background.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        background.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.gutter)
                make.right.equalTo(safeAreaLayoutGuide).offset(-Styles.Sizes.gutter)
                make.top.equalTo(safeAreaLayoutGuide)
                make.bottom.equalTo(safeAreaLayoutGuide).offset(-Styles.Sizes.rowSpacing)
            } else {
                make.left.equalTo(contentView).offset(Styles.Sizes.gutter)
                make.right.equalTo(contentView).offset(-Styles.Sizes.gutter)
                make.top.equalTo(contentView)
                make.bottom.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
            }
        }

        label.font = Styles.Fonts.smallTitle
        label.snp.makeConstraints { make in
            make.centerY.equalTo(background)
            make.left.equalTo(Styles.Sizes.columnSpacing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? RepositoryLabel else { return }
        let color = UIColor.fromHex(viewModel.color)
        background.backgroundColor = color
        label.text = viewModel.name
        label.textColor = color.textOverlayColor
    }
    
}
