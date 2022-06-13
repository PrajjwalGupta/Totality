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
    @State var isExpanded: Bool = false
    var body: some View {
        NavigationView {
            
            List {
                ForEach(empData, id: \.id){ item in
                    
                        
                        VStack {
                            HStack {
                                Text(item.employee_name)
                                    .font(.title)
                                .padding(.top)
//                                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.trailing)
                                    
                            }.frame(maxWidth: .infinity)
                            
                           
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
                        .alert("copy/delete",isPresented: $isExpanded) {
                            Button  {
                                let newId = item.id + 100
                                let newTab = DataChild(id: newId, employee_name: item.employee_name, employee_salary: item.employee_salary, employee_age: item.employee_age, profile_image: item.profile_image)
                                empData.append(newTab)
                            } label: {
                                Text("Copy")

                            }
                        }
//                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
//                            Button  {
//                                let newId = item.id + 100
//                                let newTab = DataChild(id: newId, employee_name: item.employee_name, employee_salary: item.employee_salary, employee_age: item.employee_age, profile_image: item.profile_image)
//                                empData.append(newTab)
//                            } label: {
//                                Text("Copy")
//
//                            }
//                        }
                        
                      
                    
                }
                .onDelete(perform: { indexSet in
                    deleteAction(indexSet)
                })
            }
            .onAppear(perform: getEmpData)
            .navigationTitle("Employee Details")
           // .navigationBarTitleDisplayMode(.inline)
        }
    }
    func deleteAction(_ index: IndexSet) {
        empData.remove(atOffsets: index)
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
