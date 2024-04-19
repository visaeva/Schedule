import SwiftUI

struct CarrierView: View {
    @StateObject var viewModel = CarrierViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showFilterView = false
    @State private var selectedCarrier: CarrierList? = nil
    @State private var noOptionsAvailable = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Москва (Ярославский вокзал)" + "→" + "Санкт Петербург (Балтийский вокзал)")
                    .lineLimit(3)
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, -35)
                
                ScrollView(showsIndicators: false) {
                    if noOptionsAvailable {
                        Spacer()
                        Text("Вариантов нет")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("blackDay"))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    } else {
                        ForEach(viewModel.filteredCarrier, id: \.self) { carrier in
                            ZStack(alignment: .leading) {
                                Color.lightGrayUniversal
                                HStack {
                                    ZStack {
                                        VStack {
                                            Image(carrier.image)
                                                .resizable()
                                                .frame(width: 38, height: 38)
                                                .cornerRadius(12)
                                                .padding(.bottom, 40)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text(carrier.name)
                                            .font(.system(size: 17))
                                            .lineLimit(2)
                                            .padding(.top, -30)
                                            .foregroundColor(.black)
                                        
                                        if let transfer = carrier.transfer {
                                            Text(transfer)
                                                .font(.system(size: 12))
                                                .foregroundColor(.red)
                                                .padding(.bottom, 5)
                                        }
                                    }
                                    .padding(.horizontal, 5)
                                }
                                .padding(15)
                                
                                HStack {
                                    Text(carrier.departureTime)
                                        .font(.system(size: 17))
                                        .foregroundColor(.black)
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 74, height: 1)
                                        .foregroundColor(.black)
                                    Text(carrier.travelTime)
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 74, height: 1)
                                    Text(carrier.arrivalTime)
                                        .font(.system(size: 17))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.top, 60)
                                .padding(.leading, 15)
                                
                                Text(carrier.date)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .offset(x: 280, y: -30)
                            }
                            .frame(width: 363, height: 104)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(2)
                            .onTapGesture {
                                selectedCarrier = carrier
                            }
                            .background(NavigationLink(destination: CarrierInfo(), tag: carrier, selection: $selectedCarrier) {
                                EmptyView()
                            })
                        }
                    }
                }
                .padding(.bottom, -30)
                
                NavigationLink("Уточнить время", value: 1)
                    .navigationDestination(isPresented: $showFilterView) {
                        FilterView(carrier: $viewModel.carrier, viewModel: viewModel)
                    }
                    .opacity(0)
                Button(action: {
                    showFilterView = true
                }) {
                    Text("Уточнить время")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.blue)
                        .cornerRadius(16)
                        .font(.system(size: 17, weight: .bold))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("blackDay"))
                }
            })
            .navigationBarTitle("", displayMode: .inline)
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(viewModel.$filteredCarrier) { filteredCarrier in
            noOptionsAvailable = filteredCarrier.isEmpty
        }
    }
}

#Preview {
    CarrierView()
}
