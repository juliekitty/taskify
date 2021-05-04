import SwiftUI

struct PlayTaskView: View {
  //  @Binding var showPlay: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        /* NavigationLink(destination: MainTasksList(showForm: showForm, tasksViewModel: tasksViewModel) {
         EmptyView()
         }*/
        
        
        ZStack {
            Color(UIColor.cyan)
                .navigationTitle("Play my tasks")
                .navigationBarTitleDisplayMode( .large)
                .cornerRadius(10)
                .padding(20)
            
            
            
            VStack {
                EmptyView()
            }
            
        }
    }
}

struct PlayTaskView_Previews: PreviewProvider {

    static var previews: some View {
        PlayTaskView()
    }
}
