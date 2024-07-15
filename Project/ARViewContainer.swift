import SwiftUI
import ARKit

struct ARViewContainer: UIViewRepresentable {

    func makeUIView(context: Context) -> ARSCNView {
        //print("makeUIView")
        
        let arView = ARSCNView(frame: .zero)
        arView.delegate = context.coordinator

        let configuration = ARFaceTrackingConfiguration()
        arView.session.run(configuration)
        arView.isUserInteractionEnabled = false
        
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        //print("updateUIView")
    }

    func makeCoordinator() -> Coordinator {
        //print("makeCoordinator")
        return Coordinator(self)
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ARViewContainer
        var pointNode: SCNNode?
        var rectNode: SCNNode?

        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
    }
}
