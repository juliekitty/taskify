import SwiftUI

// Display a Sheet
struct welcomeSheetView: View {
    @Binding var showWelcomeSheetView: Bool
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("welcomeSheet") var welcomeSheetDone: Bool = false

    var body: some View {
        NavigationView {
            
            VStack {
                VStack {
                    
                    Text("Welcome to").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("Taskify").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text("App").foregroundColor(.orange).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.bottom, 10)
                    
                }//Intro VStack close
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                
                VStack (spacing: 30) {
                    HStack (spacing: 20) {
                        Image(systemName: "list.star")
                            .foregroundColor(.teal)
                            .font(.title2)
                            
                        VStack (alignment: .leading) {
                            Text("Manage your todolist").fontWeight(.semibold)
                            Text("Add some tasks, edit your todolist.")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(nil)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    HStack (spacing: 20) {
                        Image(systemName: "calendar")
                            .foregroundColor(.teal)
                            .font(.title2)
                            .padding(.trailing, 5)
                            
                            
                        VStack (alignment: .leading) {
                            Text("Plan your tasks").fontWeight(.semibold)
                            Text("Choose a date and time for each task.")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(nil)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                                        
                    HStack (spacing: 20) {
                        Image(systemName: "exclamationmark.bubble.fill")
                            .foregroundColor(.teal)
                            .font(.title2)
                            
                            
                        VStack (alignment: .leading) {
                            Text("Get reminded").fontWeight(.semibold)
                            Text("Receive a notification on the time and repeated on all chosen days.")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(nil)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    
                }
                .padding(20)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                    welcomeSheetDone = true
                } label: {
                    Text("Continue")
                        .fontWeight(.medium)
                        .padding([.top, .bottom], 15)
                        .padding([.leading, .trailing], 90)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        welcomeSheetView(showWelcomeSheetView: .constant(true))
    }
}
