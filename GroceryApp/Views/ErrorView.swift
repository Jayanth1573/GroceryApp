//
//  ErrorView.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 04/07/24.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    var body: some View {
        VStack {
            Text("Error has occured in the application.")
                .font(.headline)
                .padding(.bottom, 10)
            Text(errorWrapper.error.localizedDescription)
            Text(errorWrapper.guidance)
                .font(.caption)
        }.padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case operaionFailed
    }
    static var previews: some View{
        ErrorView(errorWrapper: ErrorWrapper(error: SampleError.operaionFailed, guidance: "Operation has failed, please try again later."))
    }
}
