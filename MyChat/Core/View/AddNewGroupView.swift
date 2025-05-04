//
//  AddNewGroupView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 30/04/25.
//

import SwiftUI

struct AddNewGroupView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: UserDisplayNameModel
    @State private var groupSubject: String = ""
    
    private var isFormValid: Bool {
        !groupSubject.isEmptyOrWhiteSpace
    }
    func saveGroup()
    {
        let group = GroupModel(subject: groupSubject)
        model.saveGroup(group: group) { error in
            if let error{
                print(error.localizedDescription)
            }else{
                dismiss()
            }
        }
    }
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    TextField("Group Subject", text: $groupSubject)
                }
                Spacer()
            }.padding()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("New Group")
                            .bold()
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel")
                        {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Create")
                        {
                            saveGroup()
                        }.disabled(!isFormValid)
                    }
                }
        }
    }
}

#Preview {
    NavigationStack{
        AddNewGroupView()
            .environmentObject(UserDisplayNameModel())
    }
}
