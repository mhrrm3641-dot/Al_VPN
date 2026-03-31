name: Android Build Final

on:
  push:
    branches: [ "main" ]
  workflow_dispatch: # Manuel olarak da başlatabilmen için

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: gradle

      # Gradle Wrapper dosyasını sistem düzeyinde otomatik oluşturur
      - name: Setup Gradle
        uses: gradle/actions/setup-gradle@v3
        with:
          gradle-version: wrapper

      # Hangi klasörde olursa olsun ana build.gradle'ı bulup derler
      - name: Build APK with Gradle
        run: |
          if [ -d "app" ]; then
            cd app && gradle assembleDebug --stacktrace
          else
            gradle assembleDebug --stacktrace
          fi

      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: AI-VPN-Debug-APK
          path: "**/build/outputs/apk/debug/*.apk"
