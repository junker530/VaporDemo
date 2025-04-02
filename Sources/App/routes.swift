import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("image") { req async throws in
        let path = app.directory.publicDirectory.appending("sample.jpg")
        let buffer = try await req.fileio.collectFile(at: path)
        
        var headers = HTTPHeaders()
        headers.contentType = .jpeg
        
        return Response(
            status: .ok,
            headers: headers,
            body: .init(buffer: buffer)
        )
    }
    
    app.get("json") {_ in
        let json = [
            "message": "Hello, Vapor!",
            "status": "success"
        ]
        let response = Response(status: .ok)
        try response.content.encode(json, as: .json)
        return response
    }
    
    try app.register(collection: MyController())
    try app.register(collection: HTTPBinController())
}
