//
//  MainTasksList.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import SwiftUI

struct MainTasksList: View {
    
    // @StateObject private var tasksViewModel: tasksViewModel = tasksViewModel()
    @State var showForm: Bool = false
    
    @StateObject var tasksViewModel: TasksViewModel = TasksViewModel()
    // @State var innerTasks: [Task]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: AddTaskView(tasksViewModel: tasksViewModel, showForm: $showForm) , isActive: $showForm) {
                    EmptyView()
                }
                List {
                    ForEach(tasksViewModel.tasks) { task in
                        VStack(alignment: .leading) {
                            Text(task.label)
                                .font(.title)
                                .foregroundColor(Color.orange)
                                .bold()
                                .padding(.bottom)
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
                                    showForm = true
                                }, label: {
                                    Text("Edit")
                                })
                                .padding(.all, 16.0)
                                Spacer()
                                Button(action: {
                                    showForm = true
                                }, label: {
                                    Image(systemName: "play.fill")
                                })
                                .padding(.all, 16.0)
                            }
                            
                        }
                        .padding(.all, 16.0)
                        
                        
                    }
                    // .onDelete(perform: removeRows)
                    // .onMove(perform: moveUser)
                }
                
                
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("My Tasks")
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            showForm = true
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
