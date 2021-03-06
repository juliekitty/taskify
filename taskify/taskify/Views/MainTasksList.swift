//
//  MainTasksList.swift
//  taskify
//
//  Created by Julie Landry on 03.05.21.
//

import SwiftUI

struct MainTasksList: View {
    
    @State private var selection: String? = nil
    // selection: tag for Navigation
    @StateObject var tasksViewModel: TasksViewModel = TasksViewModel()
    // tasksViewModel: ViewModel which stores the tasks List
    @AppStorage("welcomeSheet") var welcomeSheetDone: Bool = false
    // welcomeSheetDone: true if the user already saw the welcome Sheet

    @State var showWelcomeSheetView = false
    // showWelcomeSheetView: Toggle to display the welcomeSheet
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    
                    NavigationLink(destination: AddOrEditTaskView(tasksViewModel: tasksViewModel, editedTaskID: UUID()), tag: "addTaskTag", selection: $selection) {
                        EmptyView()
                    }
                    
                    listView
                    
                    Button(action: {
                        self.showWelcomeSheetView.toggle()
                    }) {
                        Text("What can i do?")
                            .padding()
                    }.sheet(isPresented: $showWelcomeSheetView) {
                        welcomeSheetView(showWelcomeSheetView: self.$showWelcomeSheetView)
                    } // sheet
                    
                }
                .navigationTitle("My Tasks")
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            self.selection = "addTaskTag"
                        }, label: {
                            VStack{
                                
                                Image(systemName: "plus.square.on.square")
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("AccentColor"))
                                    .accentColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                                Text("Add")
                            }
                        })
                        .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                    }
                }// toolbar
            } // VStack
        } // ZStack
        .onAppear {
            tasksViewModel.readData()
            if (welcomeSheetDone == false) {
                showWelcomeSheetView = true
            }            
            /* let path = "/" + NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0].split(separator: "/").dropLast(1).map(String.init).joined(separator: "/") + "/Library/Preferences"
             print("path: \(path)")
             */
        }
    } // NavigationView
    
    
    func deleteTask(at offsets: IndexSet) {
        tasksViewModel.deleteTask(at: offsets)
    }
    
    
    @ViewBuilder
    var listView: some View {
        if tasksViewModel.tasks.isEmpty {
            emptyListView
        } else {
            tasksListView
        }
    }
    
    // List empty state
    var emptyListView: some View {
        VStack(alignment: .center) {
            
            Text("You currently have no task in your todolist!")
                .padding()
            Text("Create a new one:")
                .padding()
                
            Button(action: {
                self.selection = "addTaskTag"
            }, label: {
                VStack{
                    
                    Image(systemName: "plus.square.on.square")
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("AccentColor"))
                        .accentColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
                    Text("Add")
                }
                .padding()
            })
            .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
            
        }
    }
    
    // List not-empty state
    var tasksListView: some View {
        List {
            
            Text("Here are your tasks!\nDelete them with the edit button\nCreate new with the add icon.")
                .padding()
            
            ForEach(tasksViewModel.tasks) { task in
                
                NavigationLink(destination: PlayTaskView(task: task, tasksViewModel: tasksViewModel)) {
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
    }
    
    
} // body


struct MainTasksList_Previews: PreviewProvider {
    
    static var previews: some View {
        let tasksViewModel: TasksViewModel = TasksViewModel()
        
        MainTasksList(tasksViewModel: tasksViewModel, showWelcomeSheetView: false)
    }
}
