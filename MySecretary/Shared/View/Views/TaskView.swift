//
//  TaskView.swift
//  MySecretary
//
//  Created by jang gukjin on 2022/01/14.
//

import SwiftUI
import Neumorphic

struct TaskView: View {
    
    // MARK: Property
    @Binding var isExpand: Bool
    @GestureState private var translation: CGFloat = 0
    let maxHeight: CGFloat
    let minHeight: CGFloat
    var tasks: [TaskMetaData]
    let currentDate: Date
    private var offset: CGFloat {
        isExpand ? 0 : maxHeight - minHeight
    }
    
    // MARK: Initializer
    init(isExpand: Binding<Bool>, maxHeight: CGFloat, minHeight: CGFloat, tasks: [TaskMetaData], currentDate: Date) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self._isExpand = isExpand
        self.tasks = tasks
        self.currentDate = currentDate
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Text("Task")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding(.top, 10)
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: currentDate)
                }) {
                    ScrollView(.vertical, showsIndicators: false) {
                        tasksList(task: task)
                    }
                    .padding()
                } else {
                    Text("No Task Found")
                        .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(50.0, corners: [.topLeft, .topRight])
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: max(self.offset + self.translation, 0))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                    print(self.offset)
                    print(self.translation)
                }.onEnded { value in
                    let snapDistance = self.maxHeight * 0.25
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isExpand = value.translation.height < 0
                }
            )
        }
        .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
    }
}

// MARK: Extension
extension TaskView {
    // MARK: Custom Methodx
    /// 해당 일의 task들
    @ViewBuilder
    func tasksList(task: TaskMetaData) -> some View {
        ForEach(task.task) { task in
            VStack(alignment: .leading, spacing: 5) {
                Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
                
                Text(task.title)
                    .font(.title2.bold())
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(task.title == "장국진" ? Color.purple.opacity(0.5).cornerRadius(10) : Color.pink.opacity(0.5).cornerRadius(10))
        }
        Spacer().frame(height: 10)
    }
}

// MARK: Preview
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(isExpand: .constant(false), maxHeight: UIScreen.main.bounds.height * 0.9, minHeight: UIScreen.main.bounds.height * 0.4, tasks: tasks, currentDate: Date())
    }
}
