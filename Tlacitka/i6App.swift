//
//  i6App.swift
//  
//
//  Created by Tomas Friml on 03.02.2022.
//

import SwiftUI
@main
struct i6App: App {
   
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewRouter)
        }

        }
}

