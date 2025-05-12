//
//  GroupListView.swift
//  MyChat
//
//  Created by Rupesh Mishra on 06/05/25.
//

import SwiftUI

struct GroupListView: View {
    let groups: [GroupModel]
    var body: some View {
        List(groups){group in
            NavigationLink{
                GroupDetailView(group: group)
            } label:{
                HStack{
                    Image(systemName: "person.2")
                    Text(group.subject)
                }
            }
        }
    }
}

#Preview {
    GroupListView(groups: [])
}
