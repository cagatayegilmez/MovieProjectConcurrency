//
//  ObservableBox.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 6.02.2026.
//

import Foundation

final class ObservableBox<Value> {

    typealias Observer = (Value) -> Void

    private let lock = NSLock()
    private var observers: [UUID: Observer] = [:]
    private let deliverOnMain: Bool

    init(deliverOnMain: Bool = true) {
        self.deliverOnMain = deliverOnMain
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Registers an observer to receive emitted values.
    ///
    /// - Parameter observer: A closure that will be called with each emitted value
    /// - Returns: A token (`UUID`) that can be used to remove the observer later
    @discardableResult
    func observe(_ observer: @escaping (Value) -> Void) -> UUID {
        let id = UUID()
        lock.lock()
        observers[id] = observer
        lock.unlock()
        return id
    }

    /// Registers an observer tied to an owner object to receive emitted values
    /// The observer closure will not be called after the owner is deallocated
    ///
    /// - Parameters:
    ///   - owner: The owning object whose lifecycle controls the observation
    ///   - observer: A closure that receives the owner and each emitted value
    /// - Returns: A token (`UUID`) that can be used to remove the observer later
    @discardableResult
    func observe<Object: AnyObject>(_ owner: Object,
                                    _ observer: @escaping (Object, Value) -> Void) -> UUID {
        observe { [weak owner] (value: Value) in
            guard let owner else {
                return
            }

            observer(owner, value)
        }
    }

    /// Removes a previously registered observer.
    ///
    /// - Parameter id: The token returned when registering the observer
    func remove(_ id: UUID) {
        lock.lock()
        observers[id] = nil
        lock.unlock()
    }

    /// Removes all registered observers.
    func removeAll() {
        lock.lock()
        observers.removeAll()
        lock.unlock()
    }

    /// Emits a value to all registered observers.
    /// Delivery occurs on the main thread if `deliverOnMain` is `true`.
    ///
    /// - Parameter value: The value to emit to observers
    func emit(_ value: Value) {
        lock.lock()
        let current = Array(observers.values)
        lock.unlock()

        let deliver = {
            current.forEach {
                $0(value)
            }
        }

        if deliverOnMain, !Thread.isMainThread {
            DispatchQueue.main.async(execute: deliver)
        } else {
            deliver()
        }
    }
}
