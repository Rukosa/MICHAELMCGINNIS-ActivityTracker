//
//  ContentView.swift
//  MICHAELMCGINNIS-ActivityTracker
//
//  Created by Michael Mcginnis on 3/20/22.
//

import SwiftUI

struct Activity: Identifiable, Codable{
    var id = UUID()
    var activityName: String
    var timesOccured: Int
    var activityDesc: String
    //Try to add the children: in List later...
    //let activities: [Activity]?
}

struct ContentView: View {
    @State private var activities: [Activity] = []
    @State private var showingAddActivityView = false
    @State private var showingActivityDescription = false
    
    @State private var chosenAct = Activity.init(activityName: "", timesOccured: 0, activityDesc: "")
    
    //Works using your methods!
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
    func loadJson(){
        let jsonDecoder = JSONDecoder()
        let defaults = UserDefaults.standard
        guard let retreivedData = defaults.data(forKey: "Activities") else{
            print("Couldn't retrieve data")
            return
        }
        do {
            let decodedModel = try jsonDecoder.decode([Activity].self, from: retreivedData)
            self.activities = decodedModel
        } catch{
            print("Couldn't load")
        }
    }
    func removeItems(at offsets: IndexSet){
        activities.remove(atOffsets: offsets)
        saveJson()
    }
    
    var body: some View {
        VStack{
            List//($activities){$activity in
            {
                ForEach($activities){$activity in
                HStack{
                    Stepper(value: $activity.timesOccured, in: 1...999999999){
                        Text("\(activity.activityName) \(activity.timesOccured)")
                            .onTapGesture {
                                chosenAct = activity
                                print(chosenAct)
                                showingActivityDescription.toggle()
                            }
                    }
                    }
                }.onDelete(perform: removeItems)
            }
            //Can't see this in the preview window :(
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    Button(action: {
                        print(activities)
                        showingAddActivityView.toggle()
                    }) {
                        Text("Add Activity")
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $showingAddActivityView){
                        AddActivityView(activities: $activities)
                    }
                    .sheet(isPresented: $showingActivityDescription){
                        ActivityDescriptionView(chosenAct: $chosenAct)
                    }
                }
            }
        }.onAppear(perform: loadJson)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
