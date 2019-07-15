//
//  FlowerDetail.swift
//  FlowerPower
//
//  Created by Daniel Bolella on 7/12/19.
//  Copyright © 2019 Daniel Bolella. All rights reserved.
//

import SwiftUI
import AVFoundation
import Vision
import UIKit

struct FlowerDetail : View {
    let testFlower: TestFlower
    
    @State var matchResults = "Click below to run the identifier"
    
    var body: some View {
        VStack {
            Image(testFlower.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(testFlower.name)
            Spacer()
            Text(matchResults)
            Button(action: { self.identifyFlower() }) {
                Text("IDENTIFY")
            }
        }
        .navigationBarTitle(Text(testFlower.name), displayMode: .inline)
    }
    
    func identifyFlower(){
        let error = buildAndRunClassificationRequest(imageName: testFlower.imageName)
        if (error != nil) {
            print(error!)
        }
    }
    
    func buildAndRunClassificationRequest(imageName: String)  -> NSError? {
        //TODO: Do the ML coolness here
        // Vision parts
        var analysisRequests = [VNRequest]()
        let visionQueue = DispatchQueue(label: "FlowerPowerDispatch")
        let image = UIImage(named: imageName)
        let error: NSError! = nil
        
        // Setup a classification request.
        guard let objectRecognition = createClassificationRequest() else {
            return NSError(domain: "FlowerDetail", code: -1, userInfo: [NSLocalizedDescriptionKey: "The classification request failed."])
        }
        
        analysisRequests = ([objectRecognition])
        
        let requestHandler = VNImageRequestHandler(data: (image?.pngData())!, options: [:])
        visionQueue.async {
            do {
                try requestHandler.perform(analysisRequests)
            } catch {
                print("Error: Vision request failed with error \"\(error)\"")
            }
        }
        
        return error
    }
    
    func createClassificationRequest() -> VNCoreMLRequest? {
        
        do {
            let objectClassifier = try VNCoreMLModel(for: MLModel(contentsOf: FlowerClassifier_1.urlOfModelInThisBundle))
            let classificationRequest = VNCoreMLRequest(model: objectClassifier, completionHandler: { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    print("\(results.first!.identifier) : \(results.first!.confidence)")
                    if results.first!.confidence > 0.9 {
                        self.matchResults = results.first!.identifier == self.testFlower.actualClass ? "Match!" : "Not a match!"
                    }
                }
            })
            return classificationRequest
            
        } catch let error as NSError {
            print("Model failed to load: \(error).")
            return nil
        }
    }
}

#if DEBUG
struct FlowerDetail_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView{
            FlowerDetail(testFlower: testFlowerData[0])
        }
    }
}
#endif
