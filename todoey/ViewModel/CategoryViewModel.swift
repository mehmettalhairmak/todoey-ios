//
//  CategoryViewModel.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 22.07.2023.
//

import Foundation
import RealmSwift

protocol CategoryViewModelInterface {
    var view: CategoryViewInterface? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAtTextProperty(at indexPath: IndexPath) -> String
    func getSelectedCategory(at indexPath: IndexPath) -> Category?
    func updateModel(at indexPath: IndexPath)
    func addCategory(newCategoryName: String)
}

final class CategoryViewModel {
    weak var view: CategoryViewInterface?
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    private func loadCategories() {
        categories = realm.objects(Category.self)
    }
    
    private func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category, \(error)")
        }
        
        view?.reloadData()
    }
}

extension CategoryViewModel: CategoryViewModelInterface {
    func viewDidLoad() {
        view?.prepareCategoryView()
        loadCategories()
    }
    
    func numberOfRowsInSection() -> Int {
        return categories?.count ?? 1
    }
    
    func cellForRowAtTextProperty(at indexPath: IndexPath) -> String {
        return categories?[indexPath.row].name ?? "No Categories Added Yet"
    }
    
    func getSelectedCategory(at indexPath: IndexPath) -> Category? {
        return categories?[indexPath.row]
    }
    
    func updateModel(at indexPath: IndexPath) {
        if let item = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    func addCategory(newCategoryName: String) {
        let newCategory = Category()
        newCategory.name = newCategoryName
        
        save(category: newCategory)
    }
}
