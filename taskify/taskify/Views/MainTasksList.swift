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
                    NavigationLink(destination: PlayTaskView(), tag: "Third", selection: $selection) {
                        EmptyView()
                    }
                    
                    List {
                        
                        ForEach(tasksViewModel.tasks) { task in
                            VStack(alignment: .leading) {
                                
                                Text(task.label)
                                    .font(.title)
                                    .foregroundColor(Color.orange)
                                    .bold()
                                
                                Text(task.convertDateFormatter(date: task.startDateTime))
                                
                                ForEach(task.subtasks) { subtask in
                                    HStack {
                                        Text("- " + subtask.label)
                                            .padding(.leading)
                                            .padding(.all, 16.0)
                                    }
                                }
                                
                                HStack {
                                    Button(action: {
                                        self.selection = "Second"
                                    }, label: {
                                        Text("Edit")
                                    })
                                    .buttonStyle(BorderlessButtonStyle())
                                    .padding(16.0)
                                    .background(Color.yellow
                                                    .opacity(0.5))
                                    Spacer()
                                    
                                    Button(action: {
                                        self.selection = "Third"
                                    }, label: {
                                        Image(systemName: "play.fill")
                                    })
                                    .buttonStyle(BorderlessButtonStyle())
                                    .padding(.all, 16.0)
                                    .background(Color.yellow
                                                    .opacity(0.5))
                                }
                                
                            }
                            .padding(.all, 16.0)
                            
                            
                        } // ForEach
                        .frame(maxWidth: .infinity)
                        
                    } // List
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
                }
            }
            
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTasksList()
    }
}
