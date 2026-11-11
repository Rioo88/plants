//
//  SplashView.swift
//  Planto
//
//  Created by RIOO on 01/06/1448 AH.
//
import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 8) {                         // 🆕 مسافة أقل بين النبتة والكلمة
            Image("plantStart")
                .resizable()
                .scaledToFit()
                .frame(width: 160)

            Text("Planto")
                .font(.system(size: 40,
                              weight: .bold,
                              design: .rounded))     // 🆕 خط دائري
                .foregroundStyle(Color("PlantsGreen"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    SplashView()
}
