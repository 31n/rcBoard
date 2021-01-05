//
//  ContentView.swift
//  Shared
//
//  Created by Eizo Ishikawa on 2021/01/05.
//

import SwiftUI

struct ContentView: View {
    @State var rcbServerIP = "172.20.10.3"
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
        Button(action: {sendServer(boardID: 1)}) {
            Text("Button 1")
        }
        Button(action: {sendServer(boardID: 2)}) {
            Text("Button 2")
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
                print(String(data: data, encoding: String.Encoding.utf8) ?? "")
            }
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
