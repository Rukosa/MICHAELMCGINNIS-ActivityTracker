//
//  AddActivityView.swift
//  MICHAELMCGINNIS-ActivityTracker
//
//  Created by Michael Mcginnis on 3/20/22.
//

import SwiftUI

struct AddActivityView: View {
    @Binding var activities: [Activity]
    @Environment (\.presentationMode) var presentationMode
    //add categories??
    //add timer for tracking how long something should be done??
    @State private var activityName = ""
    @State private var timesOccured = 1
    @State private var activityDesc = "No description"
    
    @State private var activityNameOnFailedSubmit = "..."
    
    func saveJson(){
        let jsonEncoder = JSONEncoder()
        do{
            let encodedModel = try jsonEncoder.encode(activities)
            let defaults = UserDefaults.standard
            defaults.set(encodedModel, forKey: "Activities")
        } catch{
            print("Encoding error")
        }
    }
    func submitValues(){
        //@Binding lets me append!
        if(activityName.count == 0){
            activityNameOnFailedSubmit  = "Enter a name!"
            return
        }
        if(activityDesc.count == 0){
            activityDesc = "No description"
            return
        }
        activities.append(Activity.init(activityName: activityName, timesOccured: timesOccured, activityDesc: activityDesc))
        print(activities)
        saveJson()
        presentationMode.wrappedValue.dismiss()
    }
    var body: some View {
        VStack{
            Spacer()
            Text("Add your activity").font(.title.bold())
            HStack{
                Text("Activity Name:")
                    .padding(.leading)
                TextField(activityNameOnFailedSubmit, text: $activityName)
            }
            Text("Description:")
            TextEditor(text: $activityDesc)
                //.foregroundColor(.gray)
                .frame(width: 290, height: 150)
                .border(.black, width: 2)
            Stepper("Times done:  \(timesOccured)", value: $timesOccured, in: 1...99999999)
                .padding(.leading)
            Button("Submit", action: submitValues)
                .foregroundColor(.blue)
                .font(.largeTitle.bold())
                .padding(3)
            Spacer()
            Spacer()
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static private var activities: [Activity] = []
    static var previews: some View {
        AddActivityView(activities: .constant(activities))
    }
}
