//
//  ViewController.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 26.06.2023.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {
    
    var viewModel: TodoListViewModel! {
        didSet {
            viewModel.view = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = viewModel.selectedCategory?.name
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = viewModel.todoItems?[indexPath.row] {
            if #available(iOS 14.0, *) {
                var content = cell.defaultContentConfiguration()
                content.text = item.title
                cell.contentConfiguration = content
            } else {
                cell.textLabel?.text = item.title
            }
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            if #available(iOS 14.0, *) {
                var content = cell.defaultContentConfiguration()
                content.text = "No Items Added"
                cell.contentConfiguration = content
            } else {
                cell.textLabel?.text = "No Items Added"
            }
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            //What will happend once the user clicks the Add Item button on our UIAlert
            self?.viewModel.addTodoItem(itemName: textField.text!)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Delete Item from Swipe
    override func updateModel(at indexPath: IndexPath) {
        viewModel.updateModel(at: indexPath)
    }
}

//MARK: - SearchBar Methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarSearchButtonClicked(params: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            viewModel.loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

extension TodoListViewController: TodoListViewInterface {
    func prepareTodoListView() {
        
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
