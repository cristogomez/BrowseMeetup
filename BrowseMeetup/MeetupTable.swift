//
//  MeetupTable.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/2/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import UIKit

// MARK: MeetupTable: UITableViewController, MeetupManagerDelegate
class MeetupTable: UITableViewController, MeetupManagerDelegate {
  var manager: MeetupManager!                 // Class coordinator
  var groups: [Group]!                        // Data Model
  var activityView: UIActivityIndicatorView!  // UI Component
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    manager                         = MeetupManager()
    manager.communicator            = MeetupCommunicator()
    manager.communicator?.delegate  = manager
    manager.delegate                = self
    
    addActivityIndicatorView()
    manager.fetchGroups()
  }
  
  func addActivityIndicatorView() {
    let frame                               = CGRect(x: 0, y: 0, width: 40, height: 40)
    activityView                            = UIActivityIndicatorView(frame: frame)
    activityView.activityIndicatorViewStyle = .gray
    activityView.center                     = view.center
    
    activityView.startAnimating()
    view.addSubview(activityView)
  }
  
  // MARK: - MeetupManagerDelegate
  func didReceiveGroups(groups: [Group]) {
    self.groups = groups
    
    tableView.reloadData()
    activityView.stopAnimating()
  }
  
  func fetchingGroupsFailed(with error: Error) {
    print("Error \(error): \(error.localizedDescription)")
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let fetchedGroups = groups else {
      return 0
    }
    
    return fetchedGroups.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let meetupCell  =
      tableView.dequeueReusableCell(withIdentifier: "MeetupCell", for: indexPath) as! MeetupCell

    let group       = groups[indexPath.row]
    
    let labelValue  = [
      group.name!, group.who!, group.desc!, "\(group.city!), \(group.country!)"
    ]
    
    for (index, label) in meetupCell.groupLabels.enumerated() {
      label.text = labelValue[index]
    }
    
    return meetupCell
  }
}
