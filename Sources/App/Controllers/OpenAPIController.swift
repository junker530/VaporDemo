//
//  OpenAPIController.swift
//  VaporDemo
//
//  Created by Shota Sakoda on 2025/04/01.
//

import OpenAPIRuntime
import OpenAPIVapor
import Dependencies
import Vapor

struct OpenAPIController: APIProtocol {
    
    @Dependency(\.request) var request
    
    func getImage(_ input: Operations.getImage.Input) async throws -> Operations.getImage.Output {
        let path = request.application.directory.publicDirectory.appending("sample.jpg")
        var buffer = try await request.fileio.collectFile(at: path)
        
        guard let data = buffer.readData(
            length: buffer.readableBytes,
            byteTransferStrategy: .noCopy
        ) else {
            throw Abort(.badRequest)
        }
        
        return .ok(
            .init(
                body: .jpeg(
                    .init(data)
                )
            )
        )
    }
    
    func getJSON(_ input: Operations.getJSON.Input) async throws -> Operations.getJSON.Output {
        .ok(
            .init(
                body: .json(
                    .init(
                        message: "Hello, Vapor!",
                        status: "success"
                    )
                )
            )
        )
    }
}
