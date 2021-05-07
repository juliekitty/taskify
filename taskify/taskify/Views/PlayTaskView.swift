import SwiftUI

struct PlayTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var task: Task
    @ObservedObject var tasksViewModel: TasksViewModel
    @State private var selection: String? = nil
    // selection: tag for Navigation
    var body: some View {
        FirstView
            .navigationTitle(task.label)
    }
    
    private var FirstView: some View {
            
            ZStack() {
                Color.lightGrey
                VStack(alignment: .leading) {
                    Text(task.description)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                }
                .frame(width: 380, alignment: .topLeading)
                .background(Color.white)
                .padding()
                
                NavigationLink(destination: AddOrEditTaskView(tasksViewModel: tasksViewModel, editedTaskID: task.id), tag: "addTaskTag", selection: $selection) {
                    
                    Button {
                        self.selection = "addTaskTag"
                    } label: {
                        Text("Edit task")
                            .fontWeight(.medium)
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 90)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .frame(maxWidth: .infinity)
                    
                EmptyView()
                }
            }
            
        
    }
    
}


struct PlayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let myTask = Task(label: "Prepare for school", timeStamp: Date()-15*86400, recurring: [true, true, true, true,true,false,false], description: "description")
        let tasksViewModel: TasksViewModel = TasksViewModel()
        PlayTaskView(task: myTask, tasksViewModel: tasksViewModel)
    }
}
