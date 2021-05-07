import SwiftUI

struct PlayTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var task: Task
    
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
            }
            .padding()
        
    }
    
}


struct PlayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let myTask = Task(label: "Prepare for school", timeStamp: Date()-15*86400, recurring: [true, true, true, true,true,false,false], description: "description")

        PlayTaskView(task: myTask)
    }
}
