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
                        
                        Text("Here are your first tasks, you can delete them with the edit button and create some new ones with the create icon on the top right.")
                            .padding()
                        
                        ForEach(tasksViewModel.tasks) { task in
                            
                            NavigationLink(destination: PlayTaskView(task: task)) {
                                VStack(alignment: .leading) {
                                    Text(task.label)
                                        .font(.title)
                                        .foregroundColor(Color.orange)
                                    
                                    Text(task.convertDateFormatter(date: task.startDateTime))
                                    
                                    Text(task.displayRecurring())
                                }
                            }
                            .padding(16.0)
                            
                        } // ForEach
                        .onDelete(perform: delete)
                        .frame(maxWidth: .infinity)
                        
                        Text("You will get a notification for each task at the time and on the days you chose.")
                            .padding()
                        
                        Image("background")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.leading, .bottom, .trailing], -11.0)
                            .background(Color.black)
                        
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
                }// toolbar
            } // VStack
        } // ZStack
        .onAppear {
            tasksViewModel.readData()
            /* let path = "/" + NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0].split(separator: "/").dropLast(1).map(String.init).joined(separator: "/") + "/Library/Preferences"
             print("path: \(path)")
             */
        }
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
