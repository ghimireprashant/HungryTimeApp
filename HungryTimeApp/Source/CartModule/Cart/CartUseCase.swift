//
//  CartUseCase.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/14/22.
//

import Foundation

enum CartError: Error {
  case general
}

struct CartUseCase {
  
  let service: Repository
  let url: URL
  
  init(
    service: Repository = Service(),
    url: URL = URL(string: "\(AppConfigurations.baseURL.rawValue)/cars.json")!
  ) {
    self.service = service
    self.url = url
  }
  
  func retrieve(completion: @escaping (Result<Foods, CartError>) -> Void) {
    let request = URLRequest(url: url)
    service.perform(request: request) { result in
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        guard let cars = try? decoder.decode(Foods.self, from: data) else {
          completion(.failure(.general))
          return
        }
        completion(.success(cars))
      case .failure:
        completion(.failure(.general))
      }
    }
  }
}
