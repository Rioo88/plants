//
//  onboarding 1 .swift
//  plants
//
//  Created by RIOO on 29/05/1448 AH.
//

import SwiftUI

struct onboarding_1_: View {
    var body: some View {
        VStack(alignment: .leading) {

                  // العنوان
                  Text("My Plants 🌱")
                      .font(.largeTitle)
                      .bold()

                  Divider()

                  Spacer()

                  // المحتوى في النص
                  VStack(spacing: 16) {
                      Image("plantStart")

                      Text("Start your plant journey!")
                          .font(.title3)
                          .bold()

                      Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                          .font(.footnote)
                          .foregroundStyle(.secondary)
                          .multilineTextAlignment(.center)

                      // الزر
                      Button {
                          // بنكتب هنا بعدين وش يصير لما ينضغط
                      } label: {
                          Text("Set Plant Reminder")
                              .bold()
                              .foregroundStyle(.white)
                              .frame(maxWidth: .infinity)
                              .padding()
                              .background(Color("PlantGreen"))
                              .clipShape(Capsule())
                      }
                      .padding(.horizontal, 40)
                      .padding(.top, 30)
                  }
                  .frame(maxWidth: .infinity)

                  Spacer()
                  Spacer()
              }
              .padding()
          }
      }

#Preview {
    onboarding_1_()
}
