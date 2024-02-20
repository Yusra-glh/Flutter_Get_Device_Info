
# Flutter Device Info Application

This application is designed to retrieve and display various pieces of information from an Android device, including device info, MAC Address, and IMEI. It leverages the capabilities of the following packages:

- **device_info_plus (9.1.2)**: Provides detailed information about the device (hardware, OS, etc.).
- **mac_address (1.0.0)**: Allows access to the device's MAC address.
- **device_imei (0.0.4+2)**: Used to obtain the device's IMEI number.

## Getting Started

### Prerequisites

Ensure you have Flutter installed on your system. If not, follow the installation guide on the Flutter official website.

### Clone the Repository

To get started with this project, clone the repository to your local machine:

\```bash
git clone https://github.com/your-repository/flutter-device-info-app.git
cd flutter-device-info-app
\```

### Installation

After cloning the project, you need to fetch and install the dependencies defined in the `pubspec.yaml` file:

\```bash
flutter pub get
\```

### Running the Application

With the dependencies installed, you can now run the app on a connected device or an emulator:

\```bash
flutter run
\```

## Usage

Upon launching the app, it will automatically request the necessary permissions to access device information. Once granted, the app will display the device's information, MAC Address, and IMEI (if permission is granted).

## Note

- The IMEI number is only available on Android devices, and accessing it requires runtime permission from the user.
- Due to privacy concerns and restrictions on newer versions of Android, accessing the IMEI might not be possible on all devices.
