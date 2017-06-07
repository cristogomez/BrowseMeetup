//
//  MeetupCommunicator.swift
//  BrowseMeetup
//
//  Created by Emanuel Del Castillo on 6/5/17.
//  Copyright © 2017 Emanuel Del Castillo. All rights reserved.
//

import UIKit

class MeetupCommunicator {
  var delegate: MeetupCommunicatorDelegate?
  
  // MARK: Structure for building URL
  struct Meetup {
    struct Url {
      static let Scheme = "https"
      static let Host   = "api.meetup.com"
      static let Path   = "/2/groups"
    }
    
    struct ParameterKeys {
      static let APIKey       = "key"
      static let PageCount    = "page"
      static let Latitude     = "lat"
      static let Longitude    = "lon"
    }
    
    struct ParameterValues {
      static let APIKey    = "34724c7180265e491a791e47e102748"
      static let PageCount = "20"
      static let Latitude  = "18.4655"
      static let Longitude = "-66.1057"
    }
  }
  
  // MARK: Request Raw JSON object
  func searchGroups() {
    
    // List of query items
    let parameterList = [
      Meetup.ParameterKeys.Latitude  : Meetup.ParameterValues.Latitude,
      Meetup.ParameterKeys.Longitude : Meetup.ParameterValues.Longitude,
      Meetup.ParameterKeys.PageCount : Meetup.ParameterValues.PageCount,
      Meetup.ParameterKeys.APIKey    : Meetup.ParameterValues.APIKey
    ]
    
    // Create url and request
    var components         = URLComponents()
    
    components.scheme      = Meetup.Url.Scheme
    components.host        = Meetup.Url.Host
    components.path        = Meetup.Url.Path
    components.queryItems  = [URLQueryItem]()
    
    for (name, value) in parameterList {
      components.queryItems?.append(URLQueryItem(name: name, value: value))
    }
    
    guard let url = components.url else {
      print("Could not create URL from components")
      return
    }
    
    let urlRequest = URLRequest(url: url)
    
    // Create network request
    let task    = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      
      // Did we get an error?
      guard error == nil else {
        self.delegate?.fetchingGroupsFailed(with: error!)
        return
      }
      
      // Did we get a successfull response?
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                statusCode >= 200 && statusCode <= 299 else {
        print("Your request returned a status code other than 2XX!")
        return
      }
      
      // Did we receive a JSON object?
      guard let objectNotation = data else {
        print("No data was returned by the request!")
        return
      }
      
      self.delegate?.receivedGroupsJSON(objectNotation: objectNotation)
    }
    
    task.resume()
  }
}
