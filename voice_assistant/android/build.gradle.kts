allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Removed custom build directory logic to use Gradle's default build directory
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
plugins {
  id("com.android.application") version "8.7.3" apply false

  // Add the dependency for the Google services Gradle plugin
  id("com.google.gms.google-services") version "4.4.3" apply false
}
