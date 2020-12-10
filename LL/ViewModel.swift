//
//  ViewModel.swift
//  LL
//
//  Created by Jose Rivera on 10/12/2020.
//

import Foundation

protocol ViewModelInput {
    func addValue(value: String)
    func remove(index: Int)
    func getList() -> [String]
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
    
    private func updateList() {
        list = linkedList.getValues()
        self.output?.listUpdated()
    }
}

extension ViewModel: ViewModelInput {
    func getList() -> [String] {
        return list
    }
    
    func addValue(value: String) {
        linkedList.append(value: value)
        self.updateList()
    }
    
    func remove(index: Int) {
        let node = linkedList.nodeAt(index: index)
        if let node = node {
            let removedNode = linkedList.remove(node: node)
            self.output?.showMessage(title: "Information", body: "Node with value  \(removedNode) has been removed correctly")
            self.updateList()
        } else {
            self.output?.showMessage(title: "Error", body: "Error deleting node.")
        }
        
    }
}
