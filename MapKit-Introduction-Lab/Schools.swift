//
//  Schools.swift
//  MapKit-Introduction-Lab
//
//  Created by Lilia Yudina on 2/25/20.
//  Copyright © 2020 Lilia Yudina. All rights reserved.
//

import Foundation

struct School: Codable & Equatable {
let schoolName: String
let overviewParagraph: String
let location: String
  let latitude: String
  let longitude: String

  private enum CodingKeys: String, CodingKey {
      case schoolName = "school_name"
      case overviewParagraph = "overview_paragraph"
      case location
     case latitude
      case longitude
  }
}
