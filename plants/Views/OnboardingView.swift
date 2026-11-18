//
//  onboarding.swift
//  plants
//
//  Created by RIOO on 29/05/1448 AH.
//

import SwiftUI

struct OnboardingView: View {

    @State private var showSheet = false   // 🆕 ١

    var body: some View {
        VStack(alignment: .leading) {

            Text("My Plants 🌱")
                .font(.largeTitle)
                .bold()

            Divider()

            Spacer()

            VStack(spacing: 16) {
                Image("plantStart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 220)
                Text("Start your plant journey!")
                    .font(.system(size: 22))
                    .bold()

                Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                    .font(.system(size: 14))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button {
                    showSheet = true   // 🆕 ٢
                } label: {
                    Text("Set Plant Reminder")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .glassEffect(.regular.tint(Color("PlantsGreen").opacity(0.6)).interactive(), in: .capsule)
                }
                .padding(.horizontal, 40)
                .padding(.top, 30)
            }
            .frame(maxWidth: .infinity)

            Spacer()
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showSheet) {   // 🆕 ٣
            SetReminderView()
        }
    }
}

#Preview {
    OnboardingView()
        .environment(PlantViewModel())
        .preferredColorScheme(.dark)
}
