//
//  IssueLabeledCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol IssueLabeledCellDelegate: class {
    func didTapActor(cell: IssueLabeledCell)
    func didTapLabel(cell: IssueLabeledCell)
}

final class IssueLabeledCell: UICollectionViewCell {

    weak var delegate: IssueLabeledCellDelegate? = nil

    private let descriptionButton = UIButton()
    private let labelButton = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(descriptionButton)
        contentView.addSubview(labelButton)
        contentView.addSubview(dateLabel)
        
        descriptionButton.addTarget(self, action: #selector(IssueLabeledCell.onActor), for: .touchUpInside)
        descriptionButton.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.eventGutter)
                make.centerY.equalTo(safeAreaLayoutGuide)
            } else {
                make.left.equalTo(Styles.Sizes.eventGutter)
                make.centerY.equalTo(contentView)
            }
        }

        labelButton.setupAsLabel(icon: false)
        labelButton.addTarget(self, action: #selector(IssueLabeledCell.onLabel), for: .touchUpInside)
        labelButton.snp.makeConstraints { make in
            make.left.equalTo(descriptionButton.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(descriptionButton)
        }

        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(labelButton.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(labelButton)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private API

    @objc
    func onActor() {
        delegate?.didTapActor(cell: self)
    }

    @objc
    func onLabel() {
        delegate?.didTapLabel(cell: self)
    }

    // MARK: Public API

    func configure(_ model: IssueLabeledModel) {
        let actorAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color,
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold
        ]
        let actor = NSAttributedString(string: model.actor, attributes: actorAttributes)

        let actionString: String
        switch model.type {
        case .added: actionString = NSLocalizedString(" added", comment: "")
        case .removed: actionString = NSLocalizedString(" removed", comment: "")
        }
        let actionAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
            NSAttributedStringKey.font: Styles.Fonts.secondary
        ]
        let action = NSAttributedString(string: actionString, attributes: actionAttributes)
        let descriptionText = NSMutableAttributedString(attributedString: actor)
        descriptionText.append(action)
        descriptionButton.setAttributedTitle(descriptionText, for: .normal)

        let color = UIColor.fromHex(model.color)
        labelButton.backgroundColor = color

        labelButton.setTitle(model.title, for: .normal)
        labelButton.setTitleColor(color.textOverlayColor, for: .normal)

        dateLabel.setText(date: model.date)
    }

}
