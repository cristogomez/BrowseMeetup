//
//  MeetupDelegate.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/6/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import Foundation

// MARK: Parsing errors
enum MeetupError {
  enum ParsingJSONData: Error {
    case Failed
    case KeyNotFound
  }  
}

// MARK: - Root protocol
protocol MeetupDelegate {
  func fetchingGroupsFailed(with error: Error)
}
