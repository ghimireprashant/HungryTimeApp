//
//  Service.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/14/22.
//

import Foundation

protocol Repository {
  func perform(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

final class Service: Repository {
  init(
    session: URLSession = URLSession.shared
  ) {
    self.session = session
  }
  
  private let session: URLSession
  
  func perform(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
    session.dataTask(with: request) { data, _, error in
      var result: Result<Data, Error> = .failure(
        NSError(domain: "Unknown", code: 000, userInfo: nil)
      )
      if let error = error {
        result = .failure(error)
      }
      else if let data = data {
        result = .success(data)
      }
      DispatchQueue.main.async {
        completion(result)
      }
    }
    .resume()
  }
}
