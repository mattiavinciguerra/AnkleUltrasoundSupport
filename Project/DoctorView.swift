import SwiftUI

struct DoctorView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isPointLocked = false
    @State private var isRectLocked = false
    @State private var pointPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4)
    @State private var rectPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 1.55 / 2 + 95)
    @State private var rectOffsetX: CGFloat = 0
    @State private var rectOffsetY: CGFloat = 0
    @State private var rectRotation = 0.0
    
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
            
            if isPointLocked {
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: 30, height: 80)
                    .rotationEffect(Angle(degrees: rectRotation), anchor: .center)
                    .position(rectPosition)
                    .offset(x: rectOffsetX, y: rectOffsetY)
                    .opacity(0.7)
            }
            
            VStack {
                Spacer()
                
                if !isPointLocked {
                    HStack {
                        Spacer()

                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "house.fill")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        })
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                pointPosition.y -= 10
                            }, label: {
                                Image(systemName: "arrow.up")
                                    .padding()
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            })
                            .disabled(circleUpDisabled())
                            .opacity(circleUpDisabled() ? 0.4 : 1)
                            
                            HStack {
                                Button(action: {
                                    pointPosition.x -= 10
                                }, label: {
                                    Image(systemName: "arrow.left")
                                        .padding()
                                        .background(Color.teal)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                })
                                .disabled(circleLeftDisabled())
                                .opacity(circleLeftDisabled() ? 0.4 : 1)
                                
                                Button(action: {
                                    isPointLocked = true
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .padding()
                                        .background(Color.mint)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                })
                                
                                Button(action: {
                                    pointPosition.x += 10
                                }, label: {
                                    Image(systemName: "arrow.right")
                                        .padding()
                                        .background(Color.teal)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                })
                                .disabled(circleRightDisabled())
                                .opacity(circleRightDisabled() ? 0.4 : 1)
                            }
                            
                            Button(action: {
                                pointPosition.y += 10
                            }, label: {
                                Image(systemName: "arrow.down")
                                    .padding()
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            })
                            .disabled(circleDownDisabled())
                            .opacity(circleDownDisabled() ? 0.4 : 1)
                        }
                        
                        Spacer()
                    }
                } else if !isRectLocked {
                    HStack {
                        Spacer()

                        Button(action: {
                            isPointLocked = false
                        }, label: {
                            Image(systemName: "chevron.left")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        })

                        Spacer()

                        VStack {
                            Button(action: {
                                rectOffsetY -= 10
                            }, label: {
                                Image(systemName: "arrow.up")
                                    .padding()
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            })
                            .disabled(rectUpDisabled())
                            .opacity(rectUpDisabled() ? 0.4 : 1)
                            
                            HStack {
                                Button(action: {
                                    rectOffsetX -= 10
                                }, label: {
                                    Image(systemName: "arrow.left")
                                        .padding()
                                        .background(Color.teal)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                })
                                .disabled(rectLeftDisabled())
                                .opacity(rectLeftDisabled() ? 0.4 : 1)
                                
                                Button(action: {
                                    isRectLocked = true
                                    savePositions()
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .padding()
                                        .background(Color.mint)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                })
                                
                                Button(action: {
                                    rectOffsetX += 10
                                }, label: {
                                    Image(systemName: "arrow.right")
                                        .padding()
                                        .background(Color.teal)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                })
                                .disabled(rectRightDisabled())
                                .opacity(rectRightDisabled() ? 0.4 : 1)
                            }
                            
                            Button(action: {
                                rectOffsetY += 10
                            }, label: {
                                Image(systemName: "arrow.down")
                                    .padding()
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            })
                            .disabled(rectDownDisabled())
                            .opacity(rectDownDisabled() ? 0.4 : 1)
                        }

                        Spacer()

                        VStack {
                            Button(action: {
                                rectRotation -= 2
                            }, label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .padding()
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            })
                            .disabled(rotationDisabled())
                            .opacity(rotationDisabled() ? 0.4 : 1)
                            .simultaneousGesture(
                                LongPressGesture(minimumDuration: 1.0)
                                    .onEnded { _ in
                                        rectRotation -= 20
                                    }
                            )
                            
                            Button(action: {
                                rectRotation += 2
                            }, label: {
                                Image(systemName: "arrow.clockwise")
                                    .padding()
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            })
                            .disabled(rotationDisabled())
                            .opacity(rotationDisabled() ? 0.4 : 1)
                            .simultaneousGesture(
                                LongPressGesture(minimumDuration: 1.0)
                                    .onEnded { _ in
                                        rectRotation += 20
                                    }
                            )
                        }

                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isRectLocked = false
                        }, label: {
                            Image(systemName: "chevron.left")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        })

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
                        
                        Spacer()
                    }
                    .ignoresSafeArea(.all)
                    .padding(.bottom, 40)
                }
            }
            .padding(.bottom, 30)
        }
        .ignoresSafeArea(.all)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Posiziona cerchio e rettangolo")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
    }
    
    func circleUpDisabled() -> Bool {
        return pointPosition.y - 10 < arViewContainerStart + 25
    }
    
    func circleLeftDisabled() -> Bool {
        return pointPosition.x - 10 < 25
    }
    
    func circleRightDisabled() -> Bool {
        return pointPosition.x + 10 > UIScreen.main.bounds.width - 25
    }
    
    func circleDownDisabled() -> Bool {
        return pointPosition.y + 10 > arViewContainerEnd - 25
    }
    
    func rectUpDisabled() -> Bool {
        return rectOffsetY - 10 < -arViewContainerHeight / 2 + 40
    }
    
    func rectLeftDisabled() -> Bool {
        return rectOffsetX - 10 < -UIScreen.main.bounds.width / 2 + 15
    }
    
    func rectRightDisabled() -> Bool {
        return rectOffsetX + 10 > UIScreen.main.bounds.width / 2 - 15
    }
    
    func rectDownDisabled() -> Bool {
        return rectOffsetY + 10 > arViewContainerHeight / 2 - 40
    }
    
    func rotationDisabled() -> Bool {
        return (rectUpDisabled() || rectLeftDisabled() || rectRightDisabled() || rectDownDisabled())
    }
    
    func savePositions() {
        UserDefaults.standard.set(pointPosition.x, forKey: "pointX")
        UserDefaults.standard.set(pointPosition.y, forKey: "pointY")
        UserDefaults.standard.set(rectPosition.x + rectOffsetX, forKey: "rectX")
        UserDefaults.standard.set(rectPosition.y + rectOffsetY, forKey: "rectY")
        UserDefaults.standard.set(rectRotation, forKey: "rectRotation")
        print("Posizioni salvate: \(pointPosition) (\(rectPosition.x + rectOffsetX), \(rectPosition.y + rectOffsetY)) \(rectRotation)")
    }
}

struct DoctorView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorView()
    }
}
