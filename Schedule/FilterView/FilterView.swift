import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isChecked: [Bool] = [false, false, false, false]
    @State private var isYesChecked = false
    @State private var isNoChecked = false
    @Binding var carrier: [CarrierList]
    @ObservedObject var viewModel: CarrierViewModel
    @State private var noOptionsAvailable = false
    
    let timeSlots = [
        TimeSlot(name: "Утро", startTime: "06:00", endTime: "12:00"),
        TimeSlot(name: "День", startTime: "12:00", endTime: "18:00"),
        TimeSlot(name: "Вечер", startTime: "18:00", endTime: "00:00"),
        TimeSlot(name: "Ночь", startTime: "00:00", endTime: "06:00")
    ]
    
    var isAnyTimeSlotChecked: Bool {
        return isChecked.contains(true)
    }
    
    var isAnyOptionSelected: Bool {
        return isYesChecked || isNoChecked
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Время отправления")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color("blackDay"))
                ForEach(timeSlots.indices, id: \.self) { index in
                    HStack {
                        Text(timeSlots[index].name)
                            .font(.system(size: 17))
                        Text("\(timeSlots[index].startTime) - \(timeSlots[index].endTime)")
                            .font(.subheadline)
                        Spacer()
                        
                        Button(action: {
                            isChecked[index].toggle()
                        }) {
                            Image(systemName: isChecked[index] ? "checkmark.square.fill" : "square")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(isChecked[index] ? Color.blackDay : .gray)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(.horizontal)
                }
                VStack(alignment: .leading) {
                    Text("Показывать варианты с пересадками")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color("blackDay"))
                    HStack {
                        Text("Да")
                        Spacer()
                        Button(action: {
                            isYesChecked = true
                            isNoChecked = false
                        }) {
                            Image(systemName: isYesChecked ? "circle.inset.filled" : "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(isYesChecked ? Color.blackDay : .grayUniversal)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding()
                    HStack {
                        Text("Нет")
                        Spacer()
                        Button(action: {
                            isYesChecked = false
                            isNoChecked = true
                        }) {
                            Image(systemName: isNoChecked ? "circle.inset.filled" : "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(isNoChecked ? Color.blackDay : .grayUniversal)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding()
                }
                Spacer()
                if isAnyTimeSlotChecked && isAnyOptionSelected {
                    Button(action: {
                        applyFilter()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Применить")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.blueUniversal)
                            .cornerRadius(16)
                            .padding(.horizontal)
                    }
                }
            }
            .background(Color.whiteNight)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("blackDay"))
            })
            
            .navigationBarTitle("", displayMode: .inline)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func applyFilter() {
        let filteredData = carrier.filter { carrier in
            let isInSelectedTimeSlot = timeSlots.indices.contains { index in
                isChecked[index] &&
                (carrier.departureTime >= timeSlots[index].startTime &&
                 carrier.departureTime < (timeSlots[index].endTime == "00:00" ? "23:59" : timeSlots[index].endTime))
            }
            let hasTransfer = carrier.transfer?.contains("С пересадкой в Костроме") ?? false
            let isTransferSelected = isYesChecked ? hasTransfer : true
            let isNonTransferSelected = isNoChecked ? !hasTransfer : true
            
            return isInSelectedTimeSlot && isTransferSelected && isNonTransferSelected
        }
        
        if filteredData.isEmpty {
            noOptionsAvailable = true
        } else {
            noOptionsAvailable = false
        }
        
        viewModel.filteredCarrier = filteredData
    }
}

#Preview {
    FilterView( carrier: .constant([]), viewModel: CarrierViewModel())
}
