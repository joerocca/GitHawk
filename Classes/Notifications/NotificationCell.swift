//
//  NotificationDetailsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class NotificationCell: SwipeSelectableCell {

    static let labelInset = UIEdgeInsets(
        top: Styles.Fonts.title.lineHeight + 2*Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let reasonImageView = UIImageView()
    private let dateLabel = ShowMoreDetailsLabel()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(reasonImageView)
        contentView.addSubview(textLabel)
        
        titleLabel.numberOfLines = 1
        titleLabel.font = Styles.Fonts.title
        titleLabel.textColor = Styles.Colors.Gray.light.color
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(reasonImageView.snp.right).offset(Styles.Sizes.columnSpacing)
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.rowSpacing)
            } else {
                make.top.equalTo(contentView).offset(Styles.Sizes.rowSpacing)
            }
        }

        dateLabel.backgroundColor = .clear
        dateLabel.numberOfLines = 1
        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.light.color
        dateLabel.textAlignment = .right
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            if #available(iOS 11.0, *) {
                make.right.equalTo(safeAreaLayoutGuide).offset(-Styles.Sizes.gutter)
            } else {
                make.right.equalTo(contentView).offset(-Styles.Sizes.gutter)
            }
        }
        
        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.tintColor = Styles.Colors.Blue.medium.color
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.top.equalTo(textLabel)
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.rowSpacing)
            } else {
                make.left.equalTo(contentView).offset(Styles.Sizes.rowSpacing)
            }
        }

        textLabel.numberOfLines = 0
        textLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalTo(dateLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide).offset(-Styles.Sizes.rowSpacing)
            } else {
                make.bottom.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
            }
        }

        contentView.addBorder(.bottom, left: NotificationCell.labelInset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    var isRead = false {
        didSet {
            for view in [titleLabel, textLabel, reasonImageView] {
                view.alpha = isRead ? 0.5 : 1
            }
        }
    }

    func configure(_ viewModel: NotificationViewModel) {
        var titleAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.title,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.light.color
        ]
        let title = NSMutableAttributedString(string: "\(viewModel.owner)/\(viewModel.repo) ", attributes: titleAttributes)

        titleAttributes[NSAttributedStringKey.font] = Styles.Fonts.secondary
        switch viewModel.identifier {
        case .number(let number): title.append(NSAttributedString(string: "#\(number)", attributes: titleAttributes))
        default: break
        }
        titleLabel.attributedText = title

        textLabel.attributedText = viewModel.title.attributedText
        dateLabel.setText(date: viewModel.date)
        reasonImageView.image = viewModel.type.icon?.withRenderingMode(.alwaysTemplate)
        accessibilityLabel = contentView.subviews
            .flatMap { $0.accessibilityLabel }
            .reduce("", { "\($0).\n\($1)" })
            .appending(".\n\(viewModel.type.localizedString)")
    }

}
