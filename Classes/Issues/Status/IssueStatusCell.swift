//
//  IssueStatusCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueStatusCell: UICollectionViewCell, ListBindable {

    let button = UIButton()
    let lockedButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(button)
        contentView.addSubview(lockedButton)

        button.setupAsLabel()
        button.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(safeAreaLayoutGuide)
                make.left.equalTo(safeAreaLayoutGuide).offset(Styles.Sizes.gutter)
            } else {
                make.centerY.equalTo(contentView)
                make.left.equalTo(contentView).offset(Styles.Sizes.gutter)
            }
        }

        lockedButton.setTitle(Strings.locked, for: .normal)
        lockedButton.config(pullRequest: false, state: .locked)
        lockedButton.setupAsLabel()
        lockedButton.snp.makeConstraints { make in
            make.centerY.equalTo(button)
            make.left.equalTo(button.snp.right).offset(Styles.Sizes.columnSpacing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueStatusModel else { return }

        let title: String
        switch viewModel.status {
        case .closed: title = Strings.closed
        case .open: title = Strings.open
        case .merged: title = Strings.merged
        }
        button.setTitle(title, for: .normal)
        button.config(pullRequest: viewModel.pullRequest, state: viewModel.status.buttonState)

        lockedButton.isHidden = !viewModel.locked
    }

}
