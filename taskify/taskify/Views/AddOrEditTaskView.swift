import SwiftUI

struct AddOrEditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    let tasksViewModel: TasksViewModel
    
    // default values for task form
    @State var label: String = ""
    @State var description: String = ""
    @State private var date = Date()
    @State var weekdaysToggle: [Bool] = [false, false, false, false,false,false,false]
    
    // Default values for UI
    @State private var showDeleteActionSheet = false
    @State var showSubtasksSheetView = false
    @State var showValidationAlert = false
    
    // Edit mode
    let editedTaskID: UUID
    @State var editedTaskIndex: Int = -1
    // retrieve task with UUID
    @State var editMode: Bool = false
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Form {
                    VStack(alignment: .leading) {
                        Text("Label")
                            .padding(.top)
                        TextField("Label", text: $label)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("Description")
                            .padding(.top)
                        TextEditor(text: $description)
                            .frame(height: 100.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.lightGrey, lineWidth: 1)
                            )
                    }
                    .padding(.bottom)
                    VStack {
                        DatePicker(
                            "Start date",
                            selection: $date,
                            in: Date()...,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                    .padding()
                    VStack {
                        Text("Recurring on:")
                        HStack {
                            ToggleRow(weekday: weekdays[1], selection: $weekdaysToggle[1] )
                            ToggleRow(weekday: weekdays[2], selection: $weekdaysToggle[2] )
                        }
                        HStack {
                            ToggleRow(weekday: weekdays[3], selection: $weekdaysToggle[3] )
                            ToggleRow(weekday: weekdays[4], selection: $weekdaysToggle[4] )
                        }
                        HStack {
                            ToggleRow(weekday: weekdays[5], selection: $weekdaysToggle[5] )
                            Spacer(minLength: 170)
                        }
                        HStack {
                            ToggleRow(weekday: weekdays[6], selection: $weekdaysToggle[6] )
                            ToggleRow(weekday: weekdays[0], selection: $weekdaysToggle[0] )
                        }
                    } // VStack
                    .padding(.vertical)
                    Button(action: {
                        if (label.isEmpty) {
                            // deleteNotifications
                            self.showValidationAlert = true
                        } else {
                            if (self.editMode) {
                                let newTask = Task(label: label, timeStamp: date, recurring: weekdaysToggle, description: description)
                                tasksViewModel.replaceTask(index: self.editedTaskIndex, newTask: newTask)
                            } else {
                                let newTask = Task(label: label, timeStamp: date, recurring: weekdaysToggle, description: description)
                                tasksViewModel.addTask(newTask: newTask)
                            }
                            presentationMode.wrappedValue.dismiss()
                            presentationMode.wrappedValue.dismiss()
                            // TODO: find a way to go back to main view
                        }
                        
                    }, label: {
                        if (self.editMode) {
                            Text("Edit")
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            Text("Add")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    })
                } // Form
                .navigationTitle(self.editMode ? "Edit a task" : "Add a Task")
                .navigationBarTitleDisplayMode( .large)
                .alert(isPresented: $showValidationAlert) {
                    Alert(title: Text("Validation"), message: Text("Please enter a short description of your task in the label field"), dismissButton: .default(Text("OK")))
                }
                
                /*
                 Button(action: {
                 self.showSubtasksSheetView.toggle()
                 }) {
                 Text("Add subtasks")
                 }.sheet(isPresented: $showSubtasksSheetView) {
                 subtasksSheetView(showSubtasksSheetView: self.$showSubtasksSheetView)
                 } // sheet
                 
                 
                 Button("Delete this task") {
                 showDeleteActionSheet = true
                 }
                 .actionSheet(isPresented: $showDeleteActionSheet) {
                 ActionSheet(title: Text("Delete task"),
                 message: Text("Are you sure you want to delete this task?"),
                 buttons: [
                 .cancel(),
                 .destructive(
                 Text("Delete this task and substasks"),
                 action: ({
                 print("Delete")
                 }
                 
                 )
                 )
                 ]
                 )
                 } // actionSheet
                 */
                
            } // VStack
                        
        } // ZStack
        .onAppear {
            if let index = tasksViewModel.tasks.firstIndex(where: { $0.id == editedTaskID }) {
                let task:Task = tasksViewModel.tasks[index]
                self.label = task.label
                self.description = task.description
                self.date = task.startDateTime
                self.weekdaysToggle = task.recurring
                self.editMode = true
                self.editedTaskIndex = index
            }
        }
        
        
    } // body
    
} // AddTaskView


// Display a View with a toggle form control
struct ToggleRow: View {
    var weekday: String
    @Binding var selection: Bool
    
    var body: some View {
        HStack () {
            Toggle(isOn: $selection) {
                Text(String(weekday))
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
}

// Display a View with an editable List of subtask
// currently not used
struct subtasksList: View {
    @State var subTasks:[SubTask] = []
    
    var body: some View {
        
        List {
            ForEach(subTasks, id: \.id) { subTask in
                Text(subTask.label)
            }
            .onDelete(perform: delete)
        }
        .toolbar {
            EditButton()
        }
        
        Button(action: { print("save subtasks!")}) {
            Text("Save")
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        subTasks.remove(atOffsets: offsets)
    }
}

// Display a View to use in the subtasksSheetView
// currently not used
struct subtasksSheetView: View {
    @Binding var showSubtasksSheetView: Bool
    
    var body: some View {
        NavigationView {
            subtasksList()
                .navigationBarTitle(Text("Add a subtask"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSubtasksSheetView = false
                }) {
                    Text("Cancel").bold()
                })
        }
    }
}



struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let tasksViewModel: TasksViewModel = TasksViewModel()
        AddOrEditTaskView(tasksViewModel: tasksViewModel, editedTaskID: UUID())
    }
}
