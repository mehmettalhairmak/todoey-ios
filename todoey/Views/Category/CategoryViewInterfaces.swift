//
//  CategoryViewInterfaces.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 24.07.2023.
//

import Foundation

protocol CategoryViewInterface: AnyObject {
    func prepareCategoryView()
    func reloadData()
}

protocol CategoryViewModelInterface {
    var view: CategoryViewInterface? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAtTextProperty(at indexPath: IndexPath) -> String
    func getSelectedCategory(at indexPath: IndexPath) -> Category?
    func updateModel(at indexPath: IndexPath)
    func addCategory(newCategoryName: String)
}
