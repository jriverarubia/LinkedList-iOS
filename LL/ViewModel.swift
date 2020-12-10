//
//  ViewModel.swift
//  LL
//
//  Created by Jose Rivera on 10/12/2020.
//

import Foundation

protocol ViewModelInput {
    func addValue(value: String)
    func remove(node: Node<String>)    
}

protocol ViewModelOutput {
    func showMessage(title: String, body: String)
    func listUpdated()
}

class ViewModel {
    
    fileprivate let linkedList: LinkedList<String>
    var output: ViewModelOutput?
    var list: [String] = []
    
    init(linkedList: LinkedList<String>) {
        self.linkedList = linkedList
        list = linkedList.getValues()
    }
}

extension ViewModel: ViewModelInput {
    func addValue(value: String) {
        linkedList.append(value: value)
        self.output?.listUpdated()
    }
    
    func remove(node: Node<String>) {
        let removedNode = linkedList.remove(node: node)
        self.output?.showMessage(title: "Information", body: "Node with value  \(removedNode) has been removed correctly")
        self.output?.listUpdated()
    }
}
