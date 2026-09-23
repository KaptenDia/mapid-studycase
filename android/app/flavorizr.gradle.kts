import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.example.baseproject.dev"
            resValue(type = "string", name = "app_name", value = "Base App Dev")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.example.baseproject.staging"
            resValue(type = "string", name = "app_name", value = "Base App Stg")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.example.baseproject"
            resValue(type = "string", name = "app_name", value = "Base App")
        }
    }
}