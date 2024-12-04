import SwiftUI

struct ContentView: View {
    @State private var scrollToIndex: Int? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button("Scroll to Top") {
                    scrollToIndex = 0
                }
                .padding()
                
                Button("Scroll to Middle") {
                    scrollToIndex = 50
                }
                .padding()
                
                Button("Scroll to Bottom") {
                    scrollToIndex = 99
                }
                .padding()
            }
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        ForEach(0..<100) { index in
                            Text("Item \(index)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(index % 2 == 0 ? Color.blue : Color.green)
                                .id(index)
                        }
                    }
                }
                .onChange(of: scrollToIndex) { target in
                    guard let target = target else { return }
                    withAnimation {
                        proxy.scrollTo(target, anchor: .center)
                    }
                }
            }
        }
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
