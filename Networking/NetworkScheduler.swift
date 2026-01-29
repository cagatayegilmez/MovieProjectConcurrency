//
//  NetworkScheduler.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

actor NetworkScheduler {

    static let shared = NetworkScheduler()

    private var allTasks: [Task<Void, Error>] = []
    private var previousTask: Task<Void, Error>?

    func doQueue(block: @Sendable @escaping () async throws -> Void) async throws {
        let task = Task { [previousTask] in
            _ = await previousTask?.result
            return try await block()
        }

        previousTask = task
        allTasks.append(task)

        return try await task.value
    }

    func killAllTasks() {
        allTasks.forEach {
            $0.cancel()
        }

        previousTask = nil
        allTasks.removeAll()
    }
}
