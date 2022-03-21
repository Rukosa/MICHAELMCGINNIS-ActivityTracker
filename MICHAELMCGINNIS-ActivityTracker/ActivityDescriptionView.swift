//
//  ActivityDescriptionView.swift
//  MICHAELMCGINNIS-ActivityTracker
//
//  Created by Michael Mcginnis on 3/21/22.
//

import SwiftUI

struct ActivityDescriptionView: View {
    @Binding var chosenAct: Activity
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Dismiss")
                    .font(.body)
                    .foregroundColor(.blue)
                    .padding(.top)
            })
            Text("\(chosenAct.activityName)")
                .font(.largeTitle)
                .padding(.bottom)
            Text("You've done it \(chosenAct.timesOccured) times!")
                .padding(.bottom)
            Text("Description:")
                .font(.title)
                .padding(.bottom, 1)
            Text("\(chosenAct.activityDesc)")
                .padding(.leading)
                .padding(.trailing)
            Spacer()
        }
    }
}

struct ActivityDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDescriptionView(chosenAct: .constant(Activity.init(activityName: "", timesOccured: 0, activityDesc: "")))
    }
}
