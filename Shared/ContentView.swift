//
//  ContentView.swift
//  Shared
//
//  Created by Eizo Ishikawa on 2021/01/05.
//

import SwiftUI

struct ContentView: View {
    @State var rcbServerIP = "18.183.171.202"
    let lYellow = Color(red: 255/255, green: 224/255, blue: 94/255)
    let dYellow = Color(red: 213/255, green: 157/255, blue: 48/255)
    let eBlue = Color(red: 165/255, green: 221/255, blue: 222/255)
    let eBlack = Color(red: 82/255, green: 79/255, blue: 63/255)
    let face = ["にっこりん", "むんっ", "悲しい", "嬉しい", "ウインク", "驚き"]
    //let faceNum = 4
    var body: some View {
        Spacer(minLength: 20)
        Text("Control for RinachanBoard")
            .font(.title)
        Spacer(minLength: 20)
        HStack{
            Spacer(minLength: 10)
            TextField("IP address", text: $rcbServerIP)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer(minLength: 10)
            Button(action: {setIP(address: rcbServerIP)}) {
                Text("OK")
            }
            Spacer(minLength: 10)
        }
        Spacer(minLength: 20)
        let HLen = Int(floor(Double((face.count)/4)))
        VStack{
            VStack{
                ForEach(0..<HLen) { j in
                    HStack{
                        ForEach((j*4)..<(j*4+4)) { i in
                            Spacer()
                            Button(action: {sendServer(boardID: i)}, label: {
                                ZStack{
                                    Text(face[i])
                                        .accentColor(eBlack)
                                    Circle()
                                        .stroke(dYellow, lineWidth: 2)
                                        .frame(width: 78, height: 78)
                                }
                            })
                            Spacer()
                        }
                    }

                }
                HStack{
                    ForEach(4*HLen..<face.count) { i in
                        Spacer()
                        Button(action: {sendServer(boardID: i)}, label: {
                            ZStack{
                                Text(face[i])
                                    .accentColor(eBlack)
                                Circle()
                                    .stroke(dYellow, lineWidth: 2)
                                    .frame(width: 78, height: 78)
                            }
                        })
                        Spacer()
                    }
                }
                
            }
        }
        Spacer()
    }
    
    func setIP(address: String){
        print(Int(floor(Double(face.count)/4)))
        print(address)
    }
    
    
    func sendServer(boardID: Int){
        let link = URL(string: "http://" + rcbServerIP + "/RCB/main.php?boardid=" + String(boardID))!
        let request = URLRequest(url: link)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data, let response = response as? HTTPURLResponse {
                // HTTPヘッダの取得
                print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
                // HTTPステータスコード
                print("statusCode: \(response.statusCode)")
                print(String(data: data, encoding: String.Encoding.utf8) ?? "404")
                print(type(of: data))
            }
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
