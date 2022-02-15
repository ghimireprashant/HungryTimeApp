//
//  Food.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/12/22.
//

import Foundation

struct FoodModel: Codable {
  let id: Int
  let name: String
  let description: String
  let price: Double
  let image: String?
  
  enum CodingKeys : String, CodingKey {
    case id
    case name = "title"
    case description
    case price
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    description = try values.decode(String.self, forKey: .description)
    price = try values.decode(Double.self, forKey: .price)
    image = "https://picsum.photos/id/\(id)/200/300"
  }
}
typealias Foods = [FoodModel]
