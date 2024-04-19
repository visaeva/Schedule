import SwiftUI

struct CarrierInfo: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Image("rzhdLogo")
                    .resizable()
                    .frame(width: 343, height: 104)
                    .cornerRadius(24)
                
                Text("ОАО «РЖД»")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("E - mail")
                        .font(.system(size: 17))
                        .padding(.bottom, -6)
                        .foregroundColor(Color("blackDay"))
                    
                    Text("i.lozgkina@yandex.ru")
                        .font(.system(size: 12))
                        .foregroundColor(Color("blueUniversal"))
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Телефон")
                        .font(.system(size: 17))
                        .padding(.bottom, -6)
                        .foregroundColor(Color("blackDay"))
                    Text("+7 (904) 329-27-71")
                        .font(.system(size: 12))
                        .foregroundColor(Color("blueUniversal"))
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("blackDay"))
            })
            .navigationBarTitle("Информация о перевозчике", displayMode: .inline)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CarrierInfo()
    
}
