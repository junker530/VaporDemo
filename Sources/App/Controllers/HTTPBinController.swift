//
//  HTTPBinController.swift
//  VaporDemo
//
//  Created by Shota Sakoda on 2025/04/01.
//

import Vapor

struct HTTPBinController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let myRoutes = routes.grouped("httpbin")
        myRoutes.get("get", use: get)
        myRoutes.get("404", use: getStatus404)
    }
    
    @Sendable
    func get(request: Request) async throws -> ClientResponse {
        try await request.client.get("https://httpbin.org/get")
    }
    
    @Sendable
    func getStatus404(request: Request) async throws -> ClientResponse {
        let response = try await request.client.get("https://httpbin.org/status/404")
        request.logger.info("status: \(response.status)") // 404 not found
        return response
    }
}
