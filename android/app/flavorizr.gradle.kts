import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.mapid.dev"
            resValue(type = "string", name = "app_name", value = "MAPID Dev")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.mapid.staging"
            resValue(type = "string", name = "app_name", value = "MAPID Stg")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.mapid"
            resValue(type = "string", name = "app_name", value = "MAPID")
        }
    }
}