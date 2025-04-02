//
//  OpenAPIController.swift
//  VaporDemo
//
//  Created by Shota Sakoda on 2025/04/01.
//

import OpenAPIRuntime
import OpenAPIVapor

struct OpenAPIController: APIProtocol {
    func getGreeting(
        _ input: Operations.getGreeting.Input
    ) async throws -> Operations.getGreeting.Output {
        let name = input.query.name ?? "Stranger"
        let greeting = Components.Schemas.Greeting(message: "Hello, \(name)!")
        return .ok(.init(body: .json(greeting)))
    }
}
