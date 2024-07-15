import SwiftUI
import ARKit

struct PatientView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var pointPosition: CGPoint = CGPoint(x: CGFloat(UserDefaults.standard.float(forKey: "pointX")), y: CGFloat(UserDefaults.standard.float(forKey: "pointY")))
    @State private var rectPosition: CGPoint = CGPoint(x: CGFloat(UserDefaults.standard.float(forKey: "rectX")), y: CGFloat(UserDefaults.standard.float(forKey: "rectY")))
    @State private var rectRotation: Double = UserDefaults.standard.double(forKey: "rectRotation")

    private var arViewContainerHeight = UIScreen.main.bounds.height / 1.55
    private var arViewContainerStart: CGFloat = 95
    private var arViewContainerEnd = 95 + UIScreen.main.bounds.height / 1.55

    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0, green: 0.2, blue: 0.5, opacity: 0.5)
                .edgesIgnoringSafeArea(.all)

            ARViewContainer()
                .frame(height: arViewContainerHeight)
                .position(x: UIScreen.main.bounds.width / 2, y: arViewContainerHeight / 2 + arViewContainerStart)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .foregroundColor(.red)
                .frame(width: 50, height: 50)
                .position(pointPosition)
                .opacity(0.7)
            
            Rectangle()
                .foregroundColor(.green)
                .frame(width: 30, height: 80)
                .rotationEffect(Angle(degrees: rectRotation), anchor: .center)
                .position(rectPosition)
                .opacity(0.7)

            VStack {
                Spacer()

                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "house.fill")
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .padding(.bottom, 70)
            }
        }
        .ignoresSafeArea(.all)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Allinea la rotula al cerchio rosso")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .onAppear(perform: {
            self.pointPosition = CGPoint(x: CGFloat(UserDefaults.standard.float(forKey: "pointX")), y: CGFloat(UserDefaults.standard.float(forKey: "pointY")))
            self.rectPosition = CGPoint(x: CGFloat(UserDefaults.standard.float(forKey: "rectX")), y: CGFloat(UserDefaults.standard.float(forKey: "rectY")))
            self.rectRotation = UserDefaults.standard.double(forKey: "rectRotation")
            print(pointPosition, rectPosition, rectRotation)
        })
    }
}

struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
        PatientView()
    }
}
