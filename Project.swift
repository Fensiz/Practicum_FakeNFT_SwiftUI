import ProjectDescription
let projectName = "iOS-FakeNFT-Extended"
let project = Project(
	name: projectName,
	organizationName: "com.example",
	packages: [
		.package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.12.0"),
		.package(url: "https://github.com/relatedcode/ProgressHUD.git", from: "14.1.3")
	],
	settings: .settings(
		base: ["SWIFT_VERSION": "6.0"],
		configurations: [
			.debug(name: "Debug", xcconfig: "./xcconfigs/project_iOS-FakeNFT-Extended.xcconfig"),
			.release(name: "Release", xcconfig: "./xcconfigs/project_iOS-FakeNFT-Extended.xcconfig")
		]
	),
	targets: [
		.target(
			name: projectName,
			destinations: [.iPhone],
			product: .app,
			bundleId: "com.example.iOS-FakeNFT-Extended",
			deploymentTargets: .iOS("17.4"),
			infoPlist: .file(path: "iOS-FakeNFT-Extended/Info.plist"),
			sources: ["iOS-FakeNFT-Extended/**"],
			resources: [
				"Resources/Assets.xcassets",
				"Resources/**/*.storyboard",
				"Resources/**/*.xcstrings"
			],
			scripts: [
				.post(
					path: "./scripts/swiftlint.sh",
					name: "SwiftLint",
					basedOnDependencyAnalysis: false
				)
			],
			dependencies: [
				.package(product: "Kingfisher"),
				.package(product: "ProgressHUD")
			],
			settings: .settings(
				base: ["SWIFT_VERSION": "6.0"],
				configurations: [
					.debug(name: "Debug", xcconfig: "./xcconfigs/target_iOS-FakeNFT-Extended.xcconfig"),
					.release(name: "Release", xcconfig: "./xcconfigs/target_iOS-FakeNFT-Extended.xcconfig")
				]
			)
		),
		.target(
			name: projectName + "Tests",
			destinations: [.iPhone],
			product: .unitTests,
			bundleId: "com.example.iOS-FakeNFT-ExtendedTests",
			deploymentTargets: .iOS("17.4"),
			infoPlist: .default,
			sources: ["iOS-FakeNFT-ExtendedTests/**"],
			dependencies: [
				.target(name: "iOS-FakeNFT-Extended")
			],
			settings: .settings(
				base: ["SWIFT_VERSION": "6.0"],
				configurations: [
					.debug(name: "Debug", xcconfig: "./xcconfigs/target_iOS-FakeNFT-ExtendedTests.xcconfig"),
					.release(name: "Release", xcconfig: "./xcconfigs/target_iOS-FakeNFT-ExtendedTests.xcconfig")
				]
			)
		),
		.target(
			name: projectName + "UITests",
			destinations: [.iPhone],
			product: .uiTests,
			bundleId: "com.example.iOS-FakeNFT-ExtendedUITests",
			deploymentTargets: .iOS("17.4"),
			infoPlist: .default,
			sources: ["iOS-FakeNFT-ExtendedUITests/**"],
			dependencies: [
				.target(name: "iOS-FakeNFT-Extended")
			],
			settings: .settings(
				base: ["SWIFT_VERSION": "6.0"],
				configurations: [
					.debug(name: "Debug", xcconfig: "./xcconfigs/target_iOS-FakeNFT-ExtendedUITests.xcconfig"),
					.release(name: "Release", xcconfig: "./xcconfigs/target_iOS-FakeNFT-ExtendedUITests.xcconfig")
				]
			)
		)
	],
	schemes: [
		Scheme.scheme(
			name: projectName,
			buildAction: .buildAction(targets: [.target(projectName)]),
			testAction: .testPlans([.path(projectName + ".xctestplan")])
		)
	]
)
