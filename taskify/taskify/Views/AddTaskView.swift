import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var tasksViewModel: TasksViewModel
    // @Binding var showForm: Bool
    // @Binding var showPlay: Bool
    
    @State var name: String = ""
    @State var age: String = ""
    let id: UUID = UUID()
    
    @State private var showActionSheet = false
    @State var showSheetView = false
    
    @State var showingAlert = false
    @State private var date = Date()
    @State var oneToggle: Bool = false
    var body: some View {
        ZStack {
            
            /*NavigationLink(
                destination: PlayTaskView(showPlay: $showPlay)) {
                EmptyView()
                
            }*/
            VStack {
                Form {
                    HStack {
                        TextField("Label", text: $name)
                    }
                    
                    HStack {
                        DatePicker(
                            "",
                            selection: $date,
                            in: Date()...,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        Image(systemName: "calendar") .font(Font.system(.callout))
                    }
                    
                    HStack {
                        TextField("Recurring on", text: $age).keyboardType(.numberPad)
                        Image(systemName: "calendar") .font(Font.system(.callout))
                    }
                    HStack {
                        VStack {
                            GameGenerationRow(weekday: Task.Weekday.Monday, selection: oneToggle)
                            GameGenerationRow(weekday: Task.Weekday.Tuesday, selection: oneToggle)
                        }
                        VStack {
                        GameGenerationRow(weekday: Task.Weekday.Wednesday, selection: oneToggle)
                        GameGenerationRow(weekday: Task.Weekday.Thursday, selection: oneToggle)
                    }
                    }
                    HStack {
                        
                        GameGenerationRow(weekday: Task.Weekday.Friday, selection: oneToggle)
                        GameGenerationRow(weekday: Task.Weekday.Saturday, selection: oneToggle)
                        GameGenerationRow(weekday: Task.Weekday.Sunday, selection: oneToggle)
                    }
                    Button(action: {
                        if (name.isEmpty || age.isEmpty) {
                            self.showingAlert = true
                        } else { // name: name, age: Int(age) ?? 0 , id: id, timeStamp: Date()
                            let newTask = Task(label: "Go to bed Routine", timeStamp: Date()-15*86400)
                            let newList = tasksViewModel.addTask(newTask: newTask)
                            print(newList.count)
                            // showForm = false
                        }
                        
                    }, label: {
                        Text("Add")
                            .frame(maxWidth: .infinity, alignment: .center)
                    })
                }.navigationTitle("Add a Task")
                .navigationBarTitleDisplayMode( .large)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Validation"), message: Text("Please enter a name and an age."), dismissButton: .default(Text("Got it!")))
                }
                
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Text("Show Sheet View")
                }.sheet(isPresented: $showSheetView) {
                    SheetView(showSheetView: self.$showSheetView)
                }
                
                Button("Delete this task") {
                    showActionSheet = true
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Resume Workout Recording"),
                                message: Text("Choose a destination for workout data"),
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
                }
            }
        }
    }
}

struct GameGenerationRow: View {
    var weekday: Task.Weekday
    @State var selection: Bool
    
    var body: some View {
        
        HStack () {
            Toggle(isOn: $selection) {
                Text(weekday.rawValue)
                    
            }
            .toggleStyle(CheckBoxToggleStyle(labelLeft: true))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
    }
    
}


struct CheckBoxToggleStyle: ToggleStyle {
    let labelLeft: Bool
    func makeBody(configuration: Configuration) -> some View {
        HStack {

            Button {
                configuration.isOn.toggle()
            } label: {
                configuration.label
            }
            .padding(5)
            .font(.body)
            .foregroundColor(configuration.isOn ? Color.orange : Color.black)
     
        }
    }
    
}

struct SheetView: View {
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView {
            Text("Sheet View content")
                .navigationBarTitle(Text("Sheet View"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                }) {
                    Text("Done").bold()
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
