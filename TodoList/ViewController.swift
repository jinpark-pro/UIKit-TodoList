//
//  ViewController.swift
//  TodoList
//
//  Created by Jungjin Park on 2024-05-24.
//

import UIKit

class ViewController: UIViewController, AddTodoViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var todoItems: [Priority: [TodoItem]] = [.low: [], .medium: [], .high: []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Todo List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTodoItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTodoScreen))
    }
    
    @objc func editTodoItem() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    @objc func showAddTodoScreen() {
        let addTodoViewController = AddTodoViewController()
        addTodoViewController.delegate = self
        navigationController?.pushViewController(addTodoViewController, animated: true)
    }
    
    func save(todoItem: TodoItem) {
        todoItems[todoItem.priority]?.append(todoItem)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return Priority.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let priority = Priority.allCases[section]
        return todoItems[priority]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Priority.allCases[section].rawValue
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let priority = Priority.allCases[indexPath.section]
        if let item = todoItems[priority]?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isCompleted ? .checkmark : .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let priority = Priority.allCases[indexPath.section]
        if var item = todoItems[priority]?[indexPath.row] {
            item.isCompleted.toggle()
            todoItems[priority]?[indexPath.row] = item
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let priority = Priority.allCases[indexPath.section]
            todoItems[priority]?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

