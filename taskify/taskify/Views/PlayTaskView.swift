import SwiftUI

struct PlayTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var task: Task
    
    var body: some View {
        
        NavigationView {
            FirstView
                .navigationTitle(task.label)
                .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var FirstView: some View {
            
            ZStack() {
                Color.red
                Text(task.label)
                
                NavigationLink(
                    destination: SecondView()) {
                    Image(systemName: "arrow.right")
                        .font(Font.system(size: 60, weight: .black))
                }

            }
        
    }
    
}



struct SecondView: View {
    @State var showThreeView: Bool = false // bool zum aktivieren des Links zu ThreeView() der bool wird programmatisch gesetzt > es ict nicht notwndig, der die Schaltflaechen Oben im Menu betaetigt werden
    
    var body: some View {
        ZStack {
            NavigationLink(destination: ThreeView(), isActive: $showThreeView) {
                EmptyView()
            }
            Color.green
            VStack(spacing: 100) {
                
                // kann per Button und per Klick auf Text ausgeloest werden
                NavigationLink(destination: ThreeView(), isActive: $showThreeView) {
                    Text("go to threeView")
                }
                // nur per Button ausgeloest werden > weil die linkView eine EmptyView() ist
               
            }
            .navigationTitle("Second")
            .navigationBarTitleDisplayMode( .large)
            
            Button(action: {
                showThreeView = true
            }, label: {
                Image(systemName: "xmark") .font(Font.system(.largeTitle).bold())
            })
            
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                showThreeView = true
            }
        }
        .onDisappear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                //                showThreeView = false
            }
        }
    }
    
}

struct ThreeView: View {
    var body: some View {
        
        ZStack {
            Color(UIColor.cyan)
                .navigationTitle("Three")
                .navigationBarTitleDisplayMode( .large)
            
        }
    }
}



struct PlayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let myTask = Task(label: "Prepare for school", timeStamp: Date()-15*86400)

        PlayTaskView(task: myTask)
    }
}
