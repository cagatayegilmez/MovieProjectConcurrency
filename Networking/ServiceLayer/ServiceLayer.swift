//
//  ServiceLayer.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import Foundation

protocol NetworkSession {

    /// Converter for response data
    ///
    ///  - Parameter request: Request object for decoding data
    ///  - Returns: Response data & URLResponse
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession { }

final class ServiceLayer {

    private let session: NetworkSession
    private let decoder: JSONDecoder

    init(session: NetworkSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    /// Request sending method which sustainable with concurrency usage
    ///
    /// - Parameters:
    ///   - request: Request object which consumes ApiRequest type
    ///   - canRetry: A boolean value of if request retryable
    ///  - Returns: Decoded response
    func send<T: APIRequest>(request: T,
                             canRetry: Bool = true) async throws -> T.Response {

#if DEBUG
        let urlRequest = request.asURLRequest()
        print("Request: \(urlRequest)")
        print("🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀")
#endif

        let (data, response) = try await session.data(for: request.asURLRequest())

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.noHttpResponse
        }

#if DEBUG
        print("🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢")
        print("HTTP Status: \(httpResponse.statusCode)")
#endif

        switch httpResponse.statusCode {
        case 200..<300:
            return try decodeSuccessBody(data, as: T.Response.self)

        default:
            throw decodeFailureBody(data, statusCode: httpResponse.statusCode)
        }
    }

    /// Decodes http success response to given response type
    ///
    ///  - Parameters:
    ///    - data: Response data
    ///    - type: Response type of request
    ///  - Returns: Decoded response
    private func decodeSuccessBody<R: Decodable>(_ data: Data, as type: R.Type) throws -> R {
        if data.isEmpty || isEmptyStringBody(data) {
            if let empty = EmptyResponse() as? R {
                return empty
            }
            throw ServiceError.noData
        }

#if DEBUG
        if let dataString = String(data: data, encoding: .utf8) {
            print(dataString)
        }
#endif

        do {
            return try decoder.decode(R.self, from: data)
        } catch {
#if DEBUG
            print("Decoding Error --> \(R.self)")
            print(error)
#endif
            throw ServiceError.decoding(error)
        }
    }

    /// Decodes http failure response to ServiceError type
    ///
    ///  - Parameters:
    ///    - data: Response data
    ///    - statusCode: HTTP status code of failure response
    ///  - Returns: Decoded error
    private func decodeFailureBody(_ data: Data, statusCode: Int) -> ServiceError {
        if let errorObject = try? decoder.decode(ServiceErrorObject.self, from: data).errorMessages.first {
#if DEBUG
            print("🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴")
            print(errorObject.message)
#endif
            return .customError(httpCode: statusCode, errorCode: errorObject.code)
        }
        return .fail(statusCode)
    }

    /// Decodes http failure response to ServiceError type
    ///
    ///  - Parameter data: Response data
    ///  - Returns: A boolean value of if data is empty string
    private func isEmptyStringBody(_ data: Data) -> Bool {
        guard let str = String(data: data, encoding: .utf8) else {
            return false
        }

        return str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

enum ServiceError: Error {

    case invalidRefreshToken
    case noHttpResponse
    case noData
    case socialMediaReauth
    case fail(Int)
    case decoding(Error)
    case customError(httpCode: Int, errorCode: Int)
}

extension ServiceError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .customError(let httpCode, let errorCode):
            return NSLocalizedString(httpCode.description, comment: "Error code:\(errorCode)")
        default:
            return NSLocalizedString("Something went wrong.", comment: "")
        }
    }
}

struct ServiceErrorObject: Decodable {
    let errorMessages: [ErrorMessageObject]

    struct ErrorMessageObject: Decodable {
        let message: String
        let code: Int
    }
}

public struct APIBaseResponse<T: Decodable>: Decodable {
    public let data: T
}
