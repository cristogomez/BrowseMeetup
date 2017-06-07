//
//  MeetupManager.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/6/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import Foundation

// MARK: MeetupManager: MeetupCommunicatorDelegate
class MeetupManager: MeetupCommunicatorDelegate {
  var communicator: MeetupCommunicator?
  var delegate    : MeetupManagerDelegate?
  
  // MARK: - Get raw JSON object
  func fetchGroups() {
    communicator?.searchGroups()
  }
  
  // MARK: - MeetupCommunicatorDelegate
  func receivedGroupsJSON(objectNotation: Data) {
    let groups: [Group]
    
    do {
        groups = try GroupBuilder.groupsFromJSON(objectNotation: objectNotation)
        delegate?.didReceiveGroups(groups: groups)
    } catch MeetupError.ParsingJSONData.Failed {
        delegate?.fetchingGroupsFailed(with: MeetupError.ParsingJSONData.Failed)
    } catch MeetupError.ParsingJSONData.KeyNotFound {
        delegate?.fetchingGroupsFailed(with: MeetupError.ParsingJSONData.KeyNotFound)
    } catch {
        print("Unknown error detected")
        return
    }
  }
  
  func fetchingGroupsFailed(with error: Error) {
    delegate?.fetchingGroupsFailed(with: error)
  }
}
