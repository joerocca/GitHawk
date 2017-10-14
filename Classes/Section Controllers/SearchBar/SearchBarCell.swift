//
//  SearchBarCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchBarCellDelegate: class {
    func didChangeSearchText(cell: SearchBarCell, query: String)
}

final class SearchBarCell: UICollectionViewCell, UISearchBarDelegate {

    weak var delegate: SearchBarCellDelegate? = nil

    private let searchBar = UISearchBar(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        
        contentView.addSubview(searchBar)

        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        searchBar.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide)
                make.right.equalTo(safeAreaLayoutGuide)
                make.centerY.equalTo(safeAreaLayoutGuide)
            } else {
                make.left.equalTo(contentView)
                make.right.equalTo(contentView)
                make.centerY.equalTo(contentView)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(query: String, placeholder: String) {
        searchBar.text = query
        searchBar.placeholder = placeholder
    }

    // MARK: Private API

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeSearchText(cell: self, query: searchText)
    }
}
