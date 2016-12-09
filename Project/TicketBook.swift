//
//  TicketBook.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TicketBook: NSObject { //, NSCoding
    
    var todos: [TicketItem] = []
    
    // ================
    //  Manual Methods
    // ================
    
    //generate todo
    func generateToDo (_ desc: String, _ detail: String, _ imageSelection: Int) -> Int? {
        return addToDo(TicketItem(desc, detail, imageSelection))
    }
    
    //manually add new todo from string
    func addToDo (_ todo: TicketItem) -> Int {
        todos.append(todo)
        return todos.index(of: todo)!
    }
    
    //remove todo
    func removeToDo (_ todo: TicketItem) {
        if let index = todos.index(of: todo) {
            todos.remove(at: index)
        }
    }
    
    //move todo
    func moveToDo (_ fromIndex: Int, _ toIndex: Int) {
        if fromIndex != toIndex {
            let todo = todos[fromIndex]
            todos.remove(at: fromIndex)
            todos.insert(todo, at: toIndex)
        }
    }
    
}
