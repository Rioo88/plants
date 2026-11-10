//
//  AllDoneView.swift
//  plants
//
//  Created by RIOO on 30/05/1448 AH.
//

import SwiftUI

struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()

            Image("plantDone")

            Text("All Done! 🎉")
                .font(.title3)
                .bold()

            Text("All Reminders Completed")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AllDoneView()
}
