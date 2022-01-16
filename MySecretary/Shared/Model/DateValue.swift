//
//  DateValue.swift
//  MySecretary
//
//  Created by jang gukjin on 2022/01/14.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}







struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

var tasks: [TaskMetaData] = [TaskMetaData(task: [Task(title: "aiden"), Task(title: "장국진"), Task(title: "장국진"), Task(title: "장국진")], taskDate: getSampleDate(offset: 1)),TaskMetaData(task: [Task(title: "aiden"), Task(title: "밥먹기")], taskDate: getSampleDate(offset: -1))]
