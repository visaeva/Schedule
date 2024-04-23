
import SwiftUI

struct StationView: View {
    @StateObject var viewModel = StationListViewModel()
    @State private var searchString = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedStation: String?
    @Binding var selectedCity: String?
    var searchResults: [StationsList] {
        if searchString.isEmpty {
            return viewModel.station
        } else {
            return viewModel.station.filter {
                $0.name.contains(searchString)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(searchText: $searchString)
                
                if searchResults.isEmpty {
                    Spacer()
                    Text("Станция не найдена")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color("blackDay"))
                        .padding()
                    Spacer()
                } else {
                    
                    List(searchResults, id: \.self) { station in
                        Button(action: {
                            selectedStation = station.name
                            presentationMode.wrappedValue.dismiss()
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            HStack {
                                Text(station.name)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(Color("blackDay"))
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("blackDay"))
                                    .frame(width: 25, height: 25)
                                    .scaleEffect(1.4)
                            }
                            .frame(height: 60)
                            .listRowSeparator(.hidden)
                            .background(Color.whiteNight)
                        }
                        .listRowBackground(Color.whiteNight)
                    }
                    .listStyle(.plain)
                }
            }
            .background(Color.whiteNight)
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
            .navigationBarTitle("Выбор станции", displayMode: .inline)
        }
    }
}

#Preview {
    StationView(selectedStation: .constant(nil), selectedCity: .constant(nil))
}
