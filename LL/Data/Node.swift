//
//  Node.swift
//  LL
//
//  Created by Jose Rivera on 10/12/2020.
//

import Foundation

public class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?

    init(value: T) {
        self.value = value
    }
}
