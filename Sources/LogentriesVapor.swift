//
//  LogentriesVapor.swift
//  LogentriesVapor
//
//  Created by Petr Pavlik on 19/11/2016.
//
//

import Vapor
import HTTP
import Dispatch

public final class Logentries: LogProtocol, Provider {

    let token: String
    private var proxyLogProtocol: LogProtocol? = nil

    init(token: String) {
        self.token = token
    }

    // MARK: Provider

    public convenience init(config: Config) throws {
        self.init(token: config["token"]!.string!)
    }

    public func boot(_: Droplet) {
        proxyLogProtocol = drop.log
        drop.log = self
    }

    public func afterInit(_: Droplet) {

    }

    public func beforeRun(_: Droplet) {

    }

    // MARK: LogProtocol

    public var enabled: [LogLevel] = LogLevel.all

    public func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {

        let content = "\(level):\(file.components(separatedBy: "/").last!):\(function):\(line): \(message)"
        print(content)

        let body = try! JSON(node: [
            "msg": content,
        ])

        DispatchQueue.global().async {
            _ = try? BasicClient.post("https://webhook.logentries.com/noformat/logs/\(self.token)", headers: [:], query: [:], body: body)
        }
    }
}
