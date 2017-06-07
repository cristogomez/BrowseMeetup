//
//  MeetupCell.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/3/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import UIKit

// MARK: MeetupCell: UITableViewCell
class MeetupCell: UITableViewCell {
  
  // MARK: Customized labels
  @IBOutlet var groupLabels: [UILabel]!
  
  // MARK: - NSObject
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - UITableViewCell
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
