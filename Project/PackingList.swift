//
//  PackingList.swift
//  Project
//
//  Created by Tarin Rickett on 10/29/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PackingList: NSObject {
    
    var suggestedToDos: [SuggestedToDoItem] = []
    var todos: [ToDoItem] = []
    
    // ===================
    //  Suggested Methods
    // ===================
    
    //generate todos
    func generateSuggested () -> [Int]? {
        let localSuggestions = [
            SuggestedToDoItem("Good walking shoes"),
            SuggestedToDoItem("Toothbrush"),
            SuggestedToDoItem("Wallet")]
        return addSuggested(localSuggestions)
    }
    
    //add new suggested todos array
    func addSuggested (_ todos: [SuggestedToDoItem]) -> [Int] {
        var indexArray: [Int] = []
        for todo in todos {
            suggestedToDos.append(todo)
            indexArray.append(suggestedToDos.index(of: todo)!)
        }
        return indexArray //todos.index(of: todo)!
    }
    
    //remove suggested todo
    func removeSuggestedToDo (_ todo: SuggestedToDoItem) {
        if let index = suggestedToDos.index(of: todo) {
            suggestedToDos.remove(at: index)
        }
    }
    
    //move suggested todo
    func moveSuggestedToDo (_ fromIndex: Int, _ toIndex: Int) {
        if fromIndex != toIndex {
            let todo = suggestedToDos[fromIndex]
            suggestedToDos.remove(at: fromIndex)
            suggestedToDos.insert(todo, at: toIndex)
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
