//
//  DependencyObjects.swift
//  ref.) https://www.avanderlee.com/swift/dependency-injection/
//
//  Created by yoshi on 2022/09/27.
//

import Data
import Domain

public class DependencyObjects { // swiftlint:disable:this file_types_order
    init() {}

    public static subscript<T>(_ dependency: DependencyObject<T>) -> T {
        get { dependency.object }
        set { dependency.object = newValue }
    }
}

public final class DependencyObject<T>: DependencyObjects {
    lazy var object = builder()
    private let builder: () -> T

    public init(_ builder: @escaping () -> T) {
        self.builder = builder
        super.init()
    }
}

@propertyWrapper
public struct Inject<T> {
    public var wrappedValue: T { object }
    private let object: T

    public init(_ dependency: DependencyObject<T>) {
        self.object = DependencyObjects[dependency]
    }
}
