import SwiftUI

struct PlaceView: View {
    @State private var isPresentingFrom = false
    @State private var isPresentingWhere = false
    @State private var fromCity: String? = nil
    @State private var toCity: String? = nil
    @State private var fromStation: String? = nil
    @State private var toStation: String? = nil
    @State private var shouldShowFindButton = false
    @State private var showCarrierView = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Button(action: {
                        isPresentingFrom = true
                    }) {
                        if let fromCity = fromCity, let fromStation = fromStation {
                            Text("\(fromCity) (\(fromStation))")
                                .foregroundColor(.black)
                                .lineLimit(1)
                        } else {
                            Text("Откуда")
                        }
                    }
                    .foregroundColor(Color("grayUniversal"))
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        isPresentingWhere = true
                    }) {
                        if let toCity = toCity, let toStation = toStation {
                            Text("\(toCity) (\(toStation))")
                                .foregroundColor(.black)
                                .lineLimit(1)
                        } else {
                            Text("Куда")
                        }
                    }
                    .foregroundColor(Color("grayUniversal"))
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.leading, 12)
                    .padding(.top, 10)
                    .padding(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: 259, maxHeight: 96)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                )
                Button(action: {
                    withAnimation {
                        let tempCity = self.fromCity
                        let tempStation = self.fromStation
                        self.fromCity = self.toCity
                        self.fromStation = self.toStation
                        self.toCity = tempCity
                        self.toStation = tempStation
                    }
                }) {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color("blueUniversal"))
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: 10)
                }
                .padding(.trailing, -60)
                .frame(width: 10, height: 20)
                
            }
            .padding(.leading, -70)
            .frame(maxWidth: 373, maxHeight: 128)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
            )
            if shouldShowFindButton {
                Button(action: apply) {
                    Text("Найти")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150, height: 60)
                        .background(Color("blueUniversal"))
                        .cornerRadius(16)
                        .padding()
                }
                .fullScreenCover(isPresented: $showCarrierView) {
                    CarrierView()
                }
            }
        }
        
        .fullScreenCover(isPresented: $isPresentingFrom) {
            CityListView(selectedCity: $fromCity, selectedStation: $fromStation)
                .onDisappear {
                    shouldShowFindButton = fromCity != nil && fromStation != nil && toCity != nil && toStation != nil
                }
        }
        
        .fullScreenCover(isPresented: $isPresentingWhere) {
            CityListView(selectedCity: $toCity, selectedStation: $toStation)
                .onDisappear {
                    shouldShowFindButton = fromCity != nil && fromStation != nil && toCity != nil && toStation != nil
                }
        }
    }
    
    private func apply() {
        guard fromCity != nil, fromStation != nil, toCity != nil, toStation != nil else {
            return
        }
        showCarrierView = true
    }
}

#Preview {
    PlaceView()
}
