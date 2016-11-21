import PackageDescription

let package = Package(
    name: "LogentriesVapor",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1)
    ]
)
