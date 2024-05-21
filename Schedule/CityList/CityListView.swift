import SwiftUI

struct CityListView: View {
    @StateObject var viewModel = CityListViewModel()
    @State private var searchString = ""
    @State private var isPresentingFrom = false
    @State private var isPresentingWhere = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showStationView = false
    @Binding var selectedCity: String?
    @Binding  var selectedStation: String?
    
    var searchResults: [CityList] {
        if searchString.isEmpty {
            return viewModel.city
        } else {
            return viewModel.city.filter {
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
                    Text("Город не найден")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color("blackDay"))
                        .padding()
                    Spacer()
                } else {
                    List(searchResults, id: \.self) { city in
                        Button(action: {
                            selectedCity = city.name
                            showStationView = true
                        }) {
                            HStack {
                                Text(city.name)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(Color("blackDay"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("blackDay"))
                                    .frame(width: 25, height: 25)
                                    .scaleEffect(1.4)
                            }
                            .frame(height: 40)
                            .background(Color.whiteNight)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.whiteNight)
                    }
                    .listStyle(.plain)
                }
            }
            .background(Color.whiteNight)
            NavigationLink(destination: StationView( selectedStation: $selectedStation, selectedCity: $selectedCity), isActive: $showStationView) {
                EmptyView()
            }
        
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("blackDay"))
                }
            }
            )
            .navigationBarTitle("Выбор города", displayMode: .inline)
        }
    }
}

#Preview {
    CityListView(selectedCity: .constant(nil), selectedStation: .constant(nil))
    
}
