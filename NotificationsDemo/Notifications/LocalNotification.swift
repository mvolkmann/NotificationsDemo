import Foundation

// This is based on the YouTube videos by Stewart Lynch
// at https://www.youtube.com/watch?v=tNaSlfLeCB0.
struct LocalNotification {
    enum ScheduleType {
        case calendar, timeInterval
    }

    var identifier: String
    var title: String
    var subtitle: String?
    var body: String
    var scheduleType: ScheduleType
    var dateComponents: DateComponents?
    var timeInterval: Double? // in seconds
    var repeats: Bool

    // This provides a way to pass data from a tapped notification
    // to the app that created the notification.
    var userInfo: [AnyHashable: Any]?

    // This describes buttons that should appear in a notification
    // when it is long-pressed.
    var categoryIdentifier: String?

    init(
        identifier: String,
        title: String,
        body: String,
        dateComponents: DateComponents,
        repeats: Bool
    ) {
        scheduleType = .calendar
        self.identifier = identifier
        self.title = title
        self.body = body
        timeInterval = nil
        self.dateComponents = dateComponents
        self.repeats = repeats
    }

    init(
        identifier: String,
        title: String,
        body: String,
        timeInterval: Double,
        repeats: Bool
    ) {
        scheduleType = .timeInterval
        self.identifier = identifier
        self.title = title
        self.body = body
        self.timeInterval = timeInterval
        dateComponents = nil
        self.repeats = repeats
    }

    static func sendNow(title: String, body: String) {
        let identifier = "r.mark.volkmann.gmail.com.NotificationsDemo"
        let notification = LocalNotification(
            identifier: identifier,
            title: title,
            body: body,
            timeInterval: 1, // seconds from now; zero doesn't work
            repeats: false
        )
        Task {
            await LocalNotificationManager.shared.schedule(
                notification: notification
            )
        }
    }
}
