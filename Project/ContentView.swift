import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var patientViewDisabled = true
    
    init() {
        // Per testing
        //clearUserDefaults()
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0, green: 0.2, blue: 0.5, opacity: 0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: PatientView()) {
                        Text("UTILIZZO PAZIENTE")
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(patientViewDisabled)
                    .opacity(patientViewDisabled ? 0.4 : 1)
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: DoctorView()) {
                        Text("👨🏻‍⚕️")
                            .font(.system(size: 38))
                            .padding()
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("GAJA: setup per caviglia")
                            .foregroundColor(.white) // Imposta il colore del titolo
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Errore"),
                    message: Text("Non è ancora stata effettuata la prima visita con il medico."),
                    primaryButton: .default(Text("OK")) {
                    },
                    secondaryButton: .cancel(Text("Annulla")) {
                    }
                )
            }
            .onAppear {
                if (UserDefaults.standard.object(forKey: "pointX") != nil) {
                    patientViewDisabled = false
                } else {
                    patientViewDisabled = true
                }
            }
        }
    }
    
    func clearUserDefaults() -> Void {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
