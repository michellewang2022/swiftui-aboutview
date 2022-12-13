import SwiftUI

@available(iOS 14, *)
struct SmallProfileView: View {
    @Binding var isLoggedin:Bool
    var userPhoto:UIImage = UIImage(systemName: "person")!
    var userName:String = ""
    var email:String = ""
    var phone:String = ""
    var onTapped: () -> Void = {
        print("SmallProfileView.onTapped() not implemented")
    }
    
    var body: some View {
        HStack {
        Image(uiImage: userPhoto)
            .resizable()
            .padding(isLoggedin ? 0 : 10)
            .background(Color(UIColor.systemGray5))
            .frame(width: 50, height: 50, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            .scaledToFit()
            .padding()
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
            VStack (alignment:.leading) {
                if isLoggedin {
                    Text(userName)
                        .font(.title2)
                    Text(email == "" ? phone : email)
                        .foregroundColor(.blue)
                        .font(.subheadline)
                } else {
                    Text("Not logged in")
                    Text("Create or Login to account")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                }
            }
            .frame(width: 200, height: 50, alignment: .leading)
            .padding(.trailing)
        }
        .border(Color.gray)
        .contentShape(Rectangle())
        .onTapGesture {
            onTapped()
        }
    }
}
