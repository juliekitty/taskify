import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var tasksViewModel: TasksViewModel
    // @Binding var showForm: Bool
    // @Binding var showPlay: Bool
    
    @State var label: String = ""
    @State var age: String = ""
    let id: UUID = UUID()
    
    @State private var showActionSheet = false
    @State var showSheetView = true
    
    @State var showingAlert = false
    @State private var date = Date()
    
    @State var oneToggle: [Bool] = [false, true, false, false,false,false,false]
    
    var body: some View {
        ZStack {

            VStack {
                
                Form {
                    HStack {
                        TextField("Label", text: $label)
                    }
                    
                    HStack {
                        DatePicker(
                            "Start date",
                            selection: $date,
                            in: Date()...,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                    VStack {
                        Text("Recurring on:")
                        HStack {
                            ToggleRow(weekday: weekdays[0], selection: oneToggle[0] )
                            ToggleRow(weekday: weekdays[1], selection: oneToggle[1] )
                        }
                        HStack {
                            ToggleRow(weekday: weekdays[2], selection: oneToggle[2] )
                            ToggleRow(weekday: weekdays[3], selection: oneToggle[3] )
                        }
                        HStack {
                            ToggleRow(weekday: weekdays[4], selection: oneToggle[4] )
                            ToggleRow(weekday: weekdays[5], selection: oneToggle[5] )
                        }
                        HStack {
                            ToggleRow(weekday: weekdays[6], selection: oneToggle[6] )
                            Spacer(minLength: 170)
                        }
                    } // VStack
                    
                    Button(action: {
                        if (label.isEmpty) {
                            self.showingAlert = true
                        } else {
                            let newTask = Task(label: label, timeStamp: date)
                            let newList = tasksViewModel.addTask(newTask: newTask)
                            print(oneToggle)
                        }
                        
                    }, label: {
                        Text("Add")
                            .frame(maxWidth: .infinity, alignment: .center)
                    })
                } // Form
                .navigationTitle("Add a Task")
                .navigationBarTitleDisplayMode( .large)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Validation"), message: Text("Please enter a label."), dismissButton: .default(Text("Got it!")))
                }
                
                
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Text("Add subtasks")
                }.sheet(isPresented: $showSheetView) {
                    SheetView(showSheetView: self.$showSheetView)
                } // sheet
                
                
                Button("Delete this task") {
                    showActionSheet = true
                }
                .actionSheet(isPresented: $showActionSheet) {
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
                
            } // VStack
        } // ZStack
    } // body
} // AddTaskView


struct ToggleRow: View {
    var weekday: String
    @State var selection: Bool
    
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

struct UsersList: View {
    @State var subTasks:[SubTask] = []
    
    var body: some View {
        NavigationView {
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
    }
    
    func delete(at offsets: IndexSet) {
        subTasks.remove(atOffsets: offsets)
    }
}

struct SheetView: View {
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView {
            UsersList()
                .navigationBarTitle(Text("Add a subtask"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                }) {
                    Text("Cancel").bold()
                })
        }
    }
}



struct AddTaskView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let tasksViewModel: TasksViewModel = TasksViewModel()
        AddTaskView(tasksViewModel: tasksViewModel)
    }
}
