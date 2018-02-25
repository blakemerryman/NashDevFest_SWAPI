//
//  SWCharacterDetailCell.swift
//  SWAPI
//
//  Created by Blake Merryman on 2/24/18.
//  Copyright © 2018 Blake Merryman. All rights reserved.
//

import UIKit

class SWCharacterDetailCell: UITableViewCell {

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    // Ensures we get the `value1` style of cell (e.g. right detail; like Settings.app).
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("\(#function) has not been implemented")
  }

}
