//
//  ContentView.swift
//  Shared
//
//  Created by Eizo Ishikawa on 2021/01/05.
//

import SwiftUI

struct ContentView: View {
    @State var rcbServerIP = "172.20.10.3"
    let lYellow = Color(red: 255/255, green: 224/255, blue: 94/255)
    let dYellow = Color(red: 213/255, green: 157/255, blue: 48/255)
    let eBlue = Color(red: 165/255, green: 221/255, blue: 222/255)
    let eBlack = Color(red: 82/255, green: 79/255, blue: 63/255)
    let face = ["にっこりん", "むんっ", "悲しい"]
    var body: some View {
        Text("Control for RinachanBoard")
            .font(.title)
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
        VStack{
            HStack{
                ForEach(0..<3) { i in
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
    
    func setIP(address: String){
        
        print(address)
    }
    
    func sendServer(boardID: Int){
        let link = URL(string: "http://" + rcbServerIP + "/project/rcb/main.php?boardid=" + String(boardID))!
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
