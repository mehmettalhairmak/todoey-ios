//
//  TodoListInterfaces.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 24.07.2023.
//

import Foundation

protocol TodoListViewInterface: AnyObject {
    func prepareTodoListView()
    func reloadData()
}

protocol TodoListViewModelInterface {
    var view: TodoListViewInterface? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func didSelectRowAt(at indexPath: IndexPath)
    func addTodoItem(itemName: String)
    func updateModel(at indexPath: IndexPath)
    func searchBarSearchButtonClicked(params: String)
}
