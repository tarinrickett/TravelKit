//
//  Itinerary.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class Itinerary: NSObject {
    
    var suggestedToDos: [SuggestedToGoItem] = []
    var todos: [ToGoItem] = []
    
    // ===================
    //  Suggested Methods
    // ===================
    
    //generate todos
    func generateSuggested () -> [Int]? {
        let localSuggestions = [
            SuggestedToGoItem("Art Museums", "Get cultured"),
            SuggestedToGoItem("Street Festivals", "Sample local foods and crafts"),
            SuggestedToGoItem("Watch the Sunset", "With a friend")]
        return addSuggested(localSuggestions)
    }
    
    //add new suggested todos array
    func addSuggested (_ todos: [SuggestedToGoItem]) -> [Int] {
        var indexArray: [Int] = []
        for todo in todos {
            suggestedToDos.append(todo)
            indexArray.append(suggestedToDos.index(of: todo)!)
        }
        return indexArray //todos.index(of: todo)!
    }
    
    //remove suggested todo
    func removeSuggestedToDo (_ todo: SuggestedToGoItem) {
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
    func generateToDo (_ desc: String, _ detail: String) -> Int? {
        return addToDo(ToGoItem(desc, detail))
    }
    
    //manually add new todo from string
    func addToDo (_ todo: ToGoItem) -> Int {
        todos.append(todo)
        return todos.index(of: todo)!
    }
    
    //remove todo
    func removeToDo (_ todo: ToGoItem) {
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
