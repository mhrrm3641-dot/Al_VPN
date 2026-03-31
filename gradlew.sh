      - name: 4. Build APK with Wrapper
        run: |
          chmod +x android/gradlew
          ./android/gradlew assembleDebug --stacktrace --warning-mode all
