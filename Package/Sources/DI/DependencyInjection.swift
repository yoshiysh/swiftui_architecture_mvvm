//
//  DependencyInjection.swift
//  ref.) https://www.avanderlee.com/swift/dependency-injection/
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Domain
import Infrastructure

public class DependencyObjects {
    init() {}
    
    public static subscript<T>(_ dependency: DependencyObject<T>) -> T {
        get { dependency.object }
        set { dependency.object = newValue }
    }
}

public final class DependencyObject<T>: DependencyObjects {
    fileprivate lazy var object = builder()
    private let builder: () -> T
    
    public init(_ builder: @escaping () -> T) {
        self.builder = builder
        super.init()
    }
}

@propertyWrapper
public struct Inject<T> {
    private let object: T
    
    public init(_ dependency: DependencyObject<T>) {
        self.object = DependencyObjects[dependency]
    }

    public var wrappedValue: T { object }
}
