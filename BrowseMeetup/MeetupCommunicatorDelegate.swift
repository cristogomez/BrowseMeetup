//
//  MeetupCommunicatorDelegate.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/5/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import Foundation

// MARK: MeetupCommunicatorDelegate: class, MeetupDelegate
protocol MeetupCommunicatorDelegate: class, MeetupDelegate {
  func receivedGroupsJSON(objectNotation: Data)
}
