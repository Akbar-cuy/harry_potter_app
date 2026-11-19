# Harry Potter App (Latihan Responsi Mobile)

Login hardcoded: username `admin`, password `admin123`.

## Cara menjalankan
1. Buat project: `flutter create harry_potter_app`
2. Ganti folder `lib/` dan file `pubspec.yaml` dengan milik project ini
3. `flutter pub get`
4. `flutter run`

## Konfigurasi Android (wajib untuk notifikasi)
1. `android/app/src/main/AndroidManifest.xml`, tambahkan di atas tag application:
   `<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>`
   `<uses-permission android:name="android.permission.INTERNET"/>`
2. `android/app/build.gradle(.kts)`: aktifkan desugaring
   compileOptions { isCoreLibraryDesugaringEnabled = true }
   dependencies { coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4") }
