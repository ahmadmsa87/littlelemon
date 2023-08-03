//
//  OnBoardingView.swift
//  LittleLemon
//
//  Created by Ahmad Saleh on 03/08/2023.
//

import SwiftUI

struct OnBoardingView: View {
    var manager: UserManager = UserManager()
    var onRegisterSucess: () -> Void
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert = false
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170)
                    .padding(.vertical, 20)
                
                FormLoginView(
                    firstName: $firstName,
                    lastName: $lastName,
                    email: $email
                )
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                Button {
                    if (
                        !firstName.isEmpty &&
                        !lastName.isEmpty &&
                        !email.isEmpty &&
                        email.isValidEmail()
                    ) {
                        saveUserDataOnLocal(manager, firstName, lastName, email)
                        onRegisterSucess()
                    } else {
                        if (
                            firstName.isEmpty ||
                            lastName.isEmpty ||
                            email.isEmpty
                        ) {
                            alertMessage = "Registration unsuccessful. Please enter all data."
                            showAlert.toggle()
                        } else {
                            if (
                                !email.isEmpty &&
                                !email.isValidEmail()
                            ) {
                                alertMessage = "The email entered is not valid"
                                showAlert.toggle()
                            }
                        }
                    }
                } label: {
                    Text(
                        "Register"
                    ).font(
                        .custom(
                            Fonts().karlaRegularFont,
                            size: 16
                        )
                    ).fontWeight(.bold)
                }.buttonStyle(
                    ButtonStyle1()
                ).padding(.horizontal, 16)
            }
        }
        .navigationBarHidden(true)
        .alert(
            isPresented: $showAlert
        ) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(
                    Text("Ok")
                ) {
                    
                }
            )
        }
        
    }
}

func saveUserDataOnLocal(
    _ manager: UserManager,
    _ firstName: String,
    _ lastName: String,
    _ email: String
) {
    manager.saveLoginDetails(firstName: firstName, lastName: lastName, email: email)
}


private struct FormLoginView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(
                "First Name *"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 16
                    )
                ).foregroundColor(Colors().GrayLight)
                .padding(.bottom, 12)
                
            TextField(
                "",
                text: $firstName
            ).padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray, lineWidth: 1)
                ).accentColor(.yellow)
                    .padding(.bottom, 16)
            Text(
                "Last Name *"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 16
                    )
                ).foregroundColor(Colors().GrayLight)
                .padding(.bottom, 12)
                
            TextField(
                "",
                text: $lastName
            ).padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray, lineWidth: 1)
            ).accentColor(.yellow)
                .padding(.bottom, 16)
            Text(
                "Email *"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 16
                    )
                ).foregroundColor(Colors().GrayLight)
                .padding(.bottom, 12)
                
            TextField(
                "",
                text: $email
            ).padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray, lineWidth: 1)
            ).accentColor(.yellow)
                
        }.padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView {
            
        }
    }
}
