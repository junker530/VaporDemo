//
//  MyController.swift
//  VaporDemo
//
//  Created by Shota Sakoda on 2025/04/01.
//

import Vapor

struct MyController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        // definite path segmentation
        let myRoutes = routes.grouped("my")
        
        myRoutes.get("image", use: getImage)
        myRoutes.get("json", use: getJson)
        myRoutes.get("notfound-500", use:notFound500)
        myRoutes.get("notfound", use: notFound)
    }
    
    @Sendable
    func getImage(request: Request) async throws -> Response {
        let path = request.application.directory.publicDirectory.appending("sample.jpg")
        let buffer = try await request.fileio.collectFile(at: path)
        
        var headers = HTTPHeaders()
        headers.contentType = .jpeg
        
        return Response(
            status: .ok,
            headers: headers,
            body: .init(buffer: buffer)
        )
    }
    
    @Sendable
    func getJson(request: Request) async throws -> Response {
        let json = [
            "message": "Hello, Vapor!",
            "status": "success"
        ]
        let response = Response(status: .ok)
        try response.content.encode(json, as: .json)
        return response
    }
    
    @Sendable
    func notFound500(request: Request) async throws -> Response {
        let image = try await request.fileio.collectFile(
            at: request.application.directory.publicDirectory
                .appending("not_found_image.png")
        )
        return Response(status: .ok)
    }
    
    @Sendable
    func notFound(request: Request) async throws -> Response {
        do {
            let _ = try await request.fileio.collectFile(
                at: request.application.directory.publicDirectory
                    .appending("not_found_image.png")
            )
            return Response(status: .ok)
        } catch {
            throw Abort(.notFound, reason: "Not found Request")
        }
    }
}
