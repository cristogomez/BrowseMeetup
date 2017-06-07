//
//  GroupBuilder.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/6/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import UIKit

class GroupBuilder {

  // MARK: Get groups from Raw JSON object
  class func groupsFromJSON(objectNotation: Data) throws -> [Group] {
    
    let parsedObject: [String : Any]!
    
    do {
        parsedObject = try JSONSerialization.jsonObject(with: objectNotation, options: .allowFragments) as! [String : Any]
    } catch {
        print("Could not parse the data as JSON: \(objectNotation)")
        throw MeetupError.ParsingJSONData.Failed
      }
    
    guard let results = parsedObject["results"] as? [[String : AnyObject]] else {
      print("Could not find key 'results' in \(parsedObject)")
      throw MeetupError.ParsingJSONData.KeyNotFound
    }
    
    var groups = [Group]()
  
    for groupDictionary in results {
      let group     = Group()
      
      if let name   = groupDictionary["name"] as? String {
        group.name  = name
      }
      
      if let description  = groupDictionary["description"] as? String {
        group.desc        = description
      }
      
      if let who  = groupDictionary["who"] as? String {
        group.who = who
      }
      
      if let state  = groupDictionary["state"] as? String {
        group.country = state
      }
      
      if let city   = groupDictionary["city"] as? String {
        group.city  = city
      }
      
      groups.append(group)
    }
    
    return groups
  }
}
