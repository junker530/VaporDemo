//
//  DependencyValues+App.swift
//  App
//
//  Created by Shota Sakoda on 2025/04/02.
//

import Dependencies
import Vapor

extension DependencyValues {
    
    var request: Request {
        get { self[RequestKey.self] }
        set { self[RequestKey.self] = newValue }
    }
    
    private enum RequestKey: DependencyKey {
        static var liveValue: Request {
            fatalError("Value of type \(Value.self) is not registered in this context")
        }
    }
}
