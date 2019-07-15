//
//  ContentView.swift
//  FlowerPower
//
//  Created by Daniel Bolella on 7/12/19.
//  Copyright © 2019 Daniel Bolella. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var testFlowers : [TestFlower] = testFlowerData
    var body: some View {
        NavigationView {
            List(testFlowers) { testFlower in
                FlowerCell(testFlower: testFlower)
            }
            .navigationBarTitle("Test Flowers")
        }
    }
}

struct FlowerCell : View {
    var testFlower : TestFlower
    var body: some View {
        return NavigationLink(destination: FlowerDetail(testFlower: testFlower)){
            HStack{
                Image(testFlower.imageName)
                    .resizable()
                    .frame(width: 100, height: 60)
                
                Text(testFlower.name)
            }
        }
    }
}



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
