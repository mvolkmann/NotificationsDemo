import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Send Notification") {
                LocalNotification.sendNow(
                    title: "My Title",
                    body: "Did you get this?"
                )
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .task {
            do {
                try await LocalNotificationManager.shared.authorize()
            } catch {
                Log.error(error)
            }
        }
    }
}
