//
//  CategoryViewController.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 27.06.2023.
//

import UIKit

final class CategoryViewController: SwipeTableViewController {
    var viewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        //move VM
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = viewModel.cellForRowAtTextProperty(at: indexPath)
            cell.selectionStyle = .none
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = viewModel.cellForRowAtTextProperty(at: indexPath)
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.getSelectedCategory(at: indexPath)
        
        let viewModel = TodoListViewModel(selectedCategory: item)
        
        let viewController = TodoListViewBuilder.make(viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    //MARK: - Delete Category from Swipe
    override func updateModel(at indexPath: IndexPath) {
        viewModel.updateModel(at: indexPath)
    }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            self?.viewModel.addCategory(newCategoryName: textField.text!)
        }
        
        alert.addAction(action)
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Add a new category."
        }
        
        present(alert, animated: true, completion: nil)
    }
}

extension CategoryViewController: CategoryViewInterface {
    func prepareCategoryView() {
        
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
