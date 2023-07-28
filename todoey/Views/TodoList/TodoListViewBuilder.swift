//
//  CategoryViewBuilder.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 24.07.2023.
//

import UIKit

final class TodoListViewBuilder {
    class func make(_ viewModel: TodoListViewModel) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as? TodoListViewController else {
            fatalError("Could not get controller from Storyboard: (TodoListViewController)")
        }
        controller.viewModel = viewModel
        return controller
    }
}
