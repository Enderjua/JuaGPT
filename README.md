![Dart](https://img.shields.io/badge/-Dart-333333?style=flat&logo=DART)
![Flutter](https://img.shields.io/badge/-Flutter-333333?style=flat&logo=Flutter&logoColor=1572B6)
![JS](https://img.shields.io/badge/-NodeJS-333333?style=flat&logo=JavaScript)
<br>
![Firebase](https://img.shields.io/badge/-Firebase-333333?style=flat&logo=firebase)
![NoSQL](https://img.shields.io/badge/-NoSQL-333333?style=flat&logo=NoSQL)
<br>
![GitHub](https://img.shields.io/badge/-GitHub-333333?style=flat&logo=github)
![Google](https://img.shields.io/badge/-google-333333?style=flat&logo=google)
<img src="https://img.shields.io/static/v1?label=enderjua&message=juagpt&color=ff3366&logo=github" alt="marijua - app.schweis.eu">
<img src="https://img.shields.io/github/stars/enderjua/juagpt?style=social" alt="stars - app.schweis.eu">
<img src="https://img.shields.io/github/forks/enderjua/juagpt?style=social" alt="forks - app.schweis.eu">
<a href="https://github.com/enderjua/juagpt/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-GPL3-ff3366" alt="License"></a>

<div align="center">
<a href="https://github.com/Enderjua/JuaGPT/assets/120639059/3f154a36-9501-49ee-bc58-ca604c3e1bc1" target="_blank"><img src="https://github.com/Enderjua/JuaGPT/assets/120639059/3f154a36-9501-49ee-bc58-ca604c3e1bc1" width="260" /></a>
<a href="https://github.com/Enderjua/JuaGPT/assets/120639059/39bd6b59-285b-4b79-93c6-9c25c251d9b3" target="_blank"><img src="https://github.com/Enderjua/JuaGPT/assets/120639059/39bd6b59-285b-4b79-93c6-9c25c251d9b3" width="260" /></a>
<a href="https://github.com/Enderjua/JuaGPT/assets/120639059/62a8d892-b6de-4ff6-ae64-982fac1c4bc8" target="_blank"><img src="https://github.com/Enderjua/JuaGPT/assets/120639059/62a8d892-b6de-4ff6-ae64-982fac1c4bc8" width="260" /></a>
<br />
<a href="https://github.com/Enderjua/JuaGPT/assets/120639059/275e8224-e8e2-4d92-8442-2def73b897a1" target="_blank"><img src="https://github.com/Enderjua/JuaGPT/assets/120639059/275e8224-e8e2-4d92-8442-2def73b897a1" width="260" /></a>
<a href="https://github.com/Enderjua/JuaGPT/assets/120639059/100d88e9-6e60-4f7d-a092-4561b97a1de6" target="_blank"><img src="https://github.com/Enderjua/JuaGPT/assets/120639059/100d88e9-6e60-4f7d-a092-4561b97a1de6" width="260" /></a>
<a href="https://github.com/Enderjua/JuaGPT/assets/120639059/d5db74cb-b2fb-4fa3-b909-eab6f694a120" target="_blank"><img src="https://github.com/Enderjua/JuaGPT/assets/120639059/d5db74cb-b2fb-4fa3-b909-eab6f694a120" width="260" /></a>
<br />
<em>Just click on the pictures of the JuaGPT application to see them!</em>
</div><br />


# Feature Summary

- 🚀 **Easy Setup:** Start in seconds with our streamlined Firebase and Google AI API setup. No extra tools required!
- 🔥 **Advanced AI Chat Models:** Experience cutting-edge AI with the latest Google AI models, delivering sophisticated conversational capabilities.
- 🔒 **Robust Security:** Your data is protected with strong Firebase database security and encryption techniques.
- 💾 **Flexible Data Storage:** Store data securely on Firebase or opt for local storage to suit your needs.
- 💸 **Totally Free:** Enjoy advanced AI chat functionalities without any cost, thanks to Google's free API access.
- 🌐 **Seamless Integration:** No need for additional installation tools, making the setup process quick and hassle-free.

JuaGPT is designed to provide a powerful, secure, and easy-to-use AI chatbot experience without any hidden costs or complex setups.

# Installation and Running

A script is provided for Windows and Linux machines to install, update, and run ENFUGUE. Copy the relevant command below and answer the on-screen prompts to choose your installation type and install optional dependencies.

## Windows
You will be able to use this app on Windows devices in the near future

## Linux
Stay tuned for the release of this app on Linux devices

## Android

**🎉 Set Up the App Manually 🎉**
<br>

🚀 **Quick Start**:<br>
    📱 **Firebase Account**: Create a Firebase account to start your journey! (👨‍💻)<br>
    🔥 **Firebase Setup**: Add Firebase to your app and power up! (🔥)<br>
    ✍️ **App Info**: Fill in the required info in `main.dart` to give your app an identity! (📝)<br>
```dart
    void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonalInformationAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'Firebase API Key',
        appId: 'App ID',
        messagingSenderId: 'senderID',
        projectId: 'projectID'),
  );
  runApp(const MyApp());
}...
```
