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
    
    @State var showWelcomeSheetView = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    
                    NavigationLink(destination: AddTaskView(tasksViewModel: tasksViewModel), tag: "Second", selection: $selection) {
                        EmptyView()
                    }
                    
                    List {
                        
                        Text("Here are your tasks!\nDelete them with the edit button\nCreate new with the add icon.")
                            .padding()
                        
                        ForEach(tasksViewModel.tasks) { task in
                            
                            NavigationLink(destination: PlayTaskView(task: task)) {
                                VStack(alignment: .leading) {
                                    Text(task.label)
                                        .font(.title)
                                        .foregroundColor(Color.orange)
                                    
                                    
                                    Text(task.displayRecurring())
                                    
                                    Text(task.convertDateFormatter(date: task.startDateTime))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(16.0)
                            
                        } // ForEach
                        .onDelete(perform: deleteTask)
                        .frame(maxWidth: .infinity)
                        
                        Text("You will get notifications for each task on the chosen time and day.")
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
                    
                    Button(action: {
                        self.showWelcomeSheetView.toggle()
                    }) {
                        Text("What can i do?")
                    }.sheet(isPresented: $showWelcomeSheetView) {
                        welcomeSheetView(showWelcomeSheetView: self.$showWelcomeSheetView)
                    } // sheet
                    
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
            showWelcomeSheetView = true
            /* let path = "/" + NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0].split(separator: "/").dropLast(1).map(String.init).joined(separator: "/") + "/Library/Preferences"
             print("path: \(path)")
             */
        }
    } // NavigationView
    
    func deleteTask(at offsets: IndexSet) {
        tasksViewModel.deleteTask(at: offsets)
    }
    
} // body
