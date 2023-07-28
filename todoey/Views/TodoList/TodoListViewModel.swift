//
//  TodoListViewModel.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 24.07.2023.
//

import Foundation
import RealmSwift

final class TodoListViewModel {
    weak var view: TodoListViewInterface?
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    init(selectedCategory: Category?) {
        self.selectedCategory = selectedCategory
        print(selectedCategory!)
    }
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
        
        view?.reloadData()
    }
}

extension TodoListViewModel: TodoListViewModelInterface {
    func viewDidLoad() {
        view?.prepareTodoListView()
        loadItems()
    }
    
    func numberOfRowsInSection() -> Int {
        return 5
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        view?.reloadData()
    }
    
    func addTodoItem(itemName: String) {
        if let currentCategory = selectedCategory {
            do {
                try realm.write {
                    let newItem = Item()
                    newItem.title = itemName
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
            } catch {
                print("Error saving new items, \(error)")
            }
        }
        view?.reloadData()
    }
    
    func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error deleting item , \(error)")
            }
        }
    }
    
    func searchBarSearchButtonClicked(params: String) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", params).sorted(byKeyPath: "dateCreated", ascending: false)
        view?.reloadData()
    }
}
