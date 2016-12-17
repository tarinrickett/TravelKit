//
//  PackingList.swift
//  Project
//
//  Created by Tarin Rickett on 10/29/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PackingList: NSObject {
    
    static var suggestedToDos: [SuggestedToDoItem] = []
    var todos: [ToDoItem] = []
    
    // ===================
    //  Suggested Methods
    // ===================

    func populateSuggested () -> [Int]? {
        return addSuggested(PackingList.suggestedToDos)
    }
    
    //add new suggested todos array
    func addSuggested (_ todos: [SuggestedToDoItem]) -> [Int] {
        var indexArray: [Int] = []
        for todo in todos {
            PackingList.suggestedToDos.append(todo)
            indexArray.append(PackingList.suggestedToDos.index(of: todo)!)
        }
        return indexArray //todos.index(of: todo)!
    }
    
    //remove suggested todo
    func removeSuggestedToDo (_ todo: SuggestedToDoItem) {
        if let index = PackingList.suggestedToDos.index(of: todo) {
            PackingList.suggestedToDos.remove(at: index)
        }
    }
    
    //move suggested todo
    func moveSuggestedToDo (_ fromIndex: Int, _ toIndex: Int) {
        if fromIndex != toIndex {
            let todo = PackingList.suggestedToDos[fromIndex]
            PackingList.suggestedToDos.remove(at: fromIndex)
            PackingList.suggestedToDos.insert(todo, at: toIndex)
        }
    }
    
    // ================
    //  Manual Methods
    // ================
    
    //generate todo
    func generateToDo (_ desc: String) -> Int? {
        return addToDo(ToDoItem(desc))
    }
    
    //manually add new todo from string
    func addToDo (_ todo: ToDoItem) -> Int {
        todos.append(todo)
        return todos.index(of: todo)!
    }
    
    //remove todo
    func removeToDo (_ todo: ToDoItem) {
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
