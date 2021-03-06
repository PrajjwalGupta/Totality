//
//  New.swift
//  Totality
//
//  Created by Prajjawal Gupta on 10/06/22.
//

import Foundation
import SwiftUI

struct EmpData: Codable {
    let status: String
    let data: [DataChild]
    let message: String
}
struct DataChild: Codable {
    let id: Int
    let employee_name: String
    let employee_salary: Int
    let employee_age: Int
    let profile_image: String
}

struct New: View {
    @State var empData = [DataChild]()
    @State private var isExpanded: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach(empData, id: \.id){ item in
                    VStack {
                        HStack {
                            Text(item.employee_name)
                                .font(.title)
                                .padding(.top)
                            Spacer()
                        }
                        HStack {
                            HStack {
                                Text("Emp_Age:")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .frame(width: 95 , height: 15)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                Text("\(item.employee_age)")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .padding(.trailing, 5)
                            }
                            HStack {
                                Text("Emp_Salary:")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .frame(width: 96 , height: 15)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                Text("\(item.employee_salary)")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                    .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 5.0, perform: {
                        isExpanded = true
                    })
                    .confirmationDialog("Copy or Delete ?", isPresented: $isExpanded) {
                        Button  {
                            let newId2 = item.id
                            let newTab = DataChild(id: newId2, employee_name: item.employee_name, employee_salary: item.employee_salary, employee_age: item.employee_age, profile_image: item.profile_image)
                            print(newId2)
                            empData.append(newTab)
                            isExpanded = false
                        }
                    label: {
                        Text("Copy")
                    }
                        Button  {
                            let itemId = item.id
                            empData.remove(at: itemId)
                            isExpanded = false
                        }
                    label: {
                        Text("Delete")
                    }
                        
                    }
                }
            }
            .onAppear(perform: getEmpData)
            .navigationTitle("Employee Details")
        }
    }
    func getEmpData() {
        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { deta,response, error in
            if let deta = deta {
                if let decodeResponse = try? JSONDecoder().decode(EmpData.self, from: deta) {
                    DispatchQueue.main.async {
                        self.empData = decodeResponse.data
                        print("ERROR: dfdfdfdf \(decodeResponse)")
                    }
                    return
                }
            }
        }.resume()
    }
}

struct New_Previews: PreviewProvider {
    static var previews: some View {
        New()
    }
}
