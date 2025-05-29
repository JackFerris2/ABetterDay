//
//  RemindersView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import SwiftUI
import SwiftData
import UserNotifications

struct RemindersView: View {
    
// Saving the date and time, cannot save as only date
    @AppStorage("ReminderTime") private var reminderTime: Double = Date().timeIntervalSince1970
// Saving user setting for reminders
    @AppStorage("RemindersOn") private var isRemindersOn = false
    
    @State private var selectedDate = Date().addingTimeInterval(86400)
    @State private var isSettingsDialogueShowing = false
    
    var formattedTime: String {
        // Fixed: use consistent lowercase 'formatter' variable name
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Reminders")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Remind yourself to do something uplifting everyday.")
                .frame(maxWidth: .infinity, alignment: .leading)

            
// Toggle to turn on or off reminders
            Toggle(isOn: $isRemindersOn) {
                Text("Toggle reminders:")
            }
            
            if isRemindersOn {
                HStack {
                    Text("What time?")
                    Spacer()
                    DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                // tool tip saying when reminders are set for
                // displaying icon
                VStack(alignment: .leading, spacing: 10) {
                    Text(Image(systemName: "bell.and.waves.left.and.right"))
                    Text("You'll receive a friendly reminder at \(formattedTime) on selected days to make your day better.")
                }
                .foregroundStyle(Color.blue)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.blue, lineWidth: 1)
                        .background(Color("light-blue"))
                }
            } else {
                // tool tip to turn reminders on
                ToolTipView(text: "Turn on reminders above to remind yourself to make each day better.")
            }
            
            Spacer()
            Image("reminders")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300)
            Spacer()
            
        }
        .padding(.trailing, 2)
        .onAppear {
            selectedDate = Date(timeIntervalSince1970: reminderTime)
        }
        .onChange(of: isRemindersOn) { oldValue, newValue in
// Check for permissions to send notifications
            let notificationCenter = UNUserNotificationCenter.current()
            
            notificationCenter.getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized:
                    print("Notifications are authorized")
// When we do have permission
// schedule the notifications
                    if newValue {
                        scheduleNotifications()
                    } else {
                        notificationCenter.removeAllPendingNotificationRequests()
                    }
                case .denied:
                    print("Notifications are denied")
// Show a dialogue saying that we cannot send notifications
// have a button to send the user to settings
// do not show date picker if the reminders are off
                    isRemindersOn = false
                    isSettingsDialogueShowing = true
                case .notDetermined:
                    print("Notification permission not determined")
                    requestNotificationPermission()
                default:
                    break
                }
            }
        }
        .onChange(of: selectedDate) { oldValue, newValue in
            let notificationCenter = UNUserNotificationCenter.current()
// unschedule all currently scheduled reminders
            notificationCenter.removeAllPendingNotificationRequests()
// schedule new ones
            scheduleNotifications()
// save selected date and time
            reminderTime = selectedDate.timeIntervalSince1970
        }
        .alert(isPresented: $isSettingsDialogueShowing) {
            Alert(
                title: Text("Notifications Disabled"),
                message: Text("Reminders require notification permission. Please go to settings and enable notifications."),
                primaryButton: .default(Text("Settings"), action: {
// go to settings
                    goToSettings()
                }),
                secondaryButton: .cancel()
            )
        }
    }
    
    func goToSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }
    }
    
// check the autocompleted work or revisit before finished
    func requestNotificationPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notifications granted")
// schedule notifications
                scheduleNotifications()
            } else {
                print("Notifications not granted")
// show dialog not granted prompt settings
                DispatchQueue.main.async {
                    isRemindersOn = false
                    isSettingsDialogueShowing = true
                }
            }
        }
    }
    
    func scheduleNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        
// Create the content of the notification
        let content = UNMutableNotificationContent()
        content.title = "A Better Day"
        content.body = "Don't forget to do something for yourself today!"
        content.sound = .default
        
// Define time components
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: selectedDate)
        dateComponents.minute = Calendar.current.component(.minute, from: selectedDate)
        
// create a trigger that repeats daily at the specified time
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
// create the notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
// Schedule the notification
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Daily notification scheduled.")
            }
        }
    }
}

#Preview {
    RemindersView()
}
