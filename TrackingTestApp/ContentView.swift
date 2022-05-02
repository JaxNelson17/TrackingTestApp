//
//  ContentView.swift
//  TrackingTestApp
//
//  Created by Jaxson Nelson on 5/2/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        let circleEntity = makeDiscs()
        arView.scene.addAnchor(circleEntity)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeDiscs() -> AnchorEntity {
        let discsModelEntity = ModelEntity()
        let circleMesh7FeetRadius = MeshResource.generatePlane(width: 4.2, depth: 4.2, cornerRadius: 4.2)
        let circleMesh5FeetRadius = MeshResource.generatePlane(width: 3, depth: 3, cornerRadius: 3)
        let circleMesh3FeetRadius = MeshResource.generatePlane(width: 1.8, depth: 1.8, cornerRadius: 1.8)
        let circleMesh1FootRadius = MeshResource.generatePlane(width: 0.6, depth: 0.6, cornerRadius: 0.6)
        let circleEntity7FeetRadius = ModelEntity(mesh: circleMesh7FeetRadius,
                                                  materials: [simpleMaterial(with: .green)])
        let circleEntity5FeetRadius = ModelEntity(mesh: circleMesh5FeetRadius,
                                                  materials: [simpleMaterial(with: .yellow)])
        let circleEntity3FeetRadius = ModelEntity(mesh: circleMesh3FeetRadius,
                                                  materials: [simpleMaterial(with: .orange)])
        let circleEntity1FootRadius = ModelEntity(mesh: circleMesh1FootRadius,
                                                  materials: [simpleMaterial(with: .red)])
        discsModelEntity.addChild(circleEntity7FeetRadius)
        discsModelEntity.addChild(circleEntity5FeetRadius)
        discsModelEntity.addChild(circleEntity3FeetRadius)
        discsModelEntity.addChild(circleEntity1FootRadius)
        circleEntity7FeetRadius.setPosition(SIMD3<Float>(x: 0, y: 0, z: 0), relativeTo: discsModelEntity)
        circleEntity5FeetRadius.setPosition(SIMD3<Float>(x: 0, y: 0.001, z: 0), relativeTo: discsModelEntity)
        circleEntity3FeetRadius.setPosition(SIMD3<Float>(x: 0, y: 0.002, z: 0), relativeTo: discsModelEntity)
        circleEntity1FootRadius.setPosition(SIMD3<Float>(x: 0, y: 0.003, z: 0), relativeTo: discsModelEntity)
        let circleAnchorEntity = AnchorEntity(plane: [.horizontal], classification: [.floor], minimumBounds: [0.2, 0.2])
        circleAnchorEntity.addChild(discsModelEntity)
        discsModelEntity.generateCollisionShapes(recursive: true)
        return circleAnchorEntity
    }

    // Custom Material for a given Color

    private func simpleMaterial(with tintColor: UIColor) -> SimpleMaterial {
        var material = SimpleMaterial()
        material.tintColor = tintColor
        material.roughness = MaterialScalarParameter(floatLiteral: 0.5)
        material.metallic = MaterialScalarParameter(floatLiteral: 0.5)
        return material
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
