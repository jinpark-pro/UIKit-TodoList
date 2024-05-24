//
//  TodoItem.swift
//  TodoList
//
//  Created by Jungjin Park on 2024-05-24.
//

import Foundation

enum Priority: String, CaseIterable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

struct TodoItem {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var priority: Priority
}
