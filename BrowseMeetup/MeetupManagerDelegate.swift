//
//  MeetupManagerDelegate.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/6/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import Foundation

// MARK: MeetupManagerDelegate: class, MeetupDelegate
protocol MeetupManagerDelegate: class, MeetupDelegate {
  func didReceiveGroups(groups: [Group])
}
