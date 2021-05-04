//
//  MainTasksList.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import SwiftUI



struct MainTasksList: View {
    
    // @StateObject private var tasksViewModel: tasksViewModel = tasksViewModel()
    @State private var selection: String? = nil
    @StateObject var tasksViewModel: TasksViewModel = TasksViewModel()
    // @State var innerTasks: [Task]
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    
                    NavigationLink(destination: AddTaskView(tasksViewModel: tasksViewModel), tag: "Second", selection: $selection) {
                        EmptyView()
                    }
                                        
                    List {
                        
                        ForEach(tasksViewModel.tasks) { task in
                            
                            VStack(alignment: .leading) {
                                NavigationLink(destination: PlayTaskView(task: task)) {
                                    
                                    Text(task.label)
                                        .font(.title)
                                        .foregroundColor(Color.orange)
                                        .bold()
                                    
                                    Text(task.convertDateFormatter(date: task.startDateTime))
                                    
                                    Text(task.displayRecurring())
                                    
                                }
                                .padding(16.0)
                                
                            }
                            
                            
                        } // ForEach
                        .onDelete(perform: delete)
                        .frame(maxWidth: .infinity)
                        
                    } // List
                    .toolbar {
                        EditButton()
                    }
                    // .listStyle(InsetListStyle())
                    
                }
                .navigationTitle("My Tasks")
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            self.selection = "Second"
                        }, label: {
                            Image(systemName: "plus.square.on.square")
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("AccentColor"))
                                .accentColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                        })
                        .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                    }
                } // toolbar
                
            } // VStack
        } // ZStack
    } // NavigationView
} // body

func delete(at offsets: IndexSet) {
    print("delete a task")
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTasksList()
    }
}
