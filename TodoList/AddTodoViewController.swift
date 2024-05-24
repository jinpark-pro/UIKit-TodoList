//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by Jungjin Park on 2024-05-24.
//

import UIKit

protocol AddTodoViewControllerDelegate {
    func save(todoItem: TodoItem)
}
class AddTodoViewController: UIViewController {

    var delegate: AddTodoViewControllerDelegate?
    var prioritySegment: UISegmentedControl!
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Todo"
        
        view.backgroundColor = .white
        prioritySegment = UISegmentedControl(items: Priority.allCases.map { $0.rawValue })
        prioritySegment!.selectedSegmentIndex = 0
        view.addSubview(prioritySegment!)
        
        prioritySegment.translatesAutoresizingMaskIntoConstraints = false
        
        textField = UITextField()
        textField.placeholder = "Enter todo title"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            prioritySegment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            prioritySegment.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        let rightButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTodo))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func addTodo() {
        guard let title = textField.text, !title.isEmpty else { return }
        
        let selectedPriority = Priority.allCases[prioritySegment.selectedSegmentIndex]
        let newItem = TodoItem(id: UUID(), title: textField.text!, isCompleted: false, priority: selectedPriority)
        delegate?.save(todoItem: newItem)
        navigationController?.popViewController(animated: true)
    }
}
