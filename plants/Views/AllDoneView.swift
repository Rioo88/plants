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
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 220)

            Text("All Done! 🎉")
                .font(.system(size: 22))
                .font(.title3)
                .bold()

            Text("All Reminders Completed")
                .font(.system(size: 14))
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
        .preferredColorScheme(.dark)
}
