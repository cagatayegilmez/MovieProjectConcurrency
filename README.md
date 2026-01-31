<div id="top">

<!-- HEADER STYLE: CLASSIC -->
<div align="center">


# MOVIEPROJECTCONCURRENCY

<em>UIKit + SwiftUI Hybrid But Only Concurrency Usage</em>

<!-- BADGES -->
<img src="https://img.shields.io/github/license/cagatayegilmez/MovieProjectConcurrency?style=flat&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
<img src="https://img.shields.io/github/last-commit/cagatayegilmez/MovieProjectConcurrency?style=flat&logo=git&logoColor=white&color=0080ff" alt="last-commit">
<img src="https://img.shields.io/github/languages/top/cagatayegilmez/MovieProjectConcurrency?style=flat&color=0080ff" alt="repo-top-language">
<img src="https://img.shields.io/github/languages/count/cagatayegilmez/MovieProjectConcurrency?style=flat&color=0080ff" alt="repo-language-count">

<em>Built with the tools and technologies:</em>

<img src="https://img.shields.io/badge/JSON-000000.svg?style=flat&logo=JSON&logoColor=white" alt="JSON">
<img src="https://img.shields.io/badge/Markdown-000000.svg?style=flat&logo=Markdown&logoColor=white" alt="Markdown">
<img src="https://img.shields.io/badge/Swift-F05138.svg?style=flat&logo=Swift&logoColor=white" alt="Swift">

</div>
<br>

---

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Usage](#usage)
    - [Testing](#testing)
- [Features](#features)
- [Project Structure](#project-structure)
    - [Project Index](#project-index)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgment](#acknowledgment)

---

## Overview

MovieProjectConcurrency is an iOS development toolkit that demonstrates sophisticated concurrency management within a hybrid UIKit and SwiftUI environment. It showcases how to build responsive, high-performance apps with clean architecture and engaging UI components. 

**Why MovieProjectConcurrency?**

This project aims to illustrate best practices in modern iOS development. The core features include:

- 🎯 **Concurrency Handling:** Efficiently manage asynchronous tasks to enhance user experience and app responsiveness.
- 🧩 **Modular Architecture:** Clear separation of concerns with coordinators, view models, and data controllers for maintainability.
- 🎨 **Rich UI Components:** Seamless integration of animated loading indicators, parallax effects, and responsive layouts.
- 🔗 **Network Layer:** Centralized request management with environment configuration for flexible API interactions.
- 🚀 **Scalable Design:** Well-structured codebase supporting future feature expansion and robust testing.

---

## Features

|      | Component       | Details                                                                                     |
| :--- | :-------------- | :------------------------------------------------------------------------------------------ |
| ⚙️  | **Architecture**  | <ul><li>Uses **concurrent programming** with **DispatchQueues** and **OperationQueues**</li><li>Implements **asynchronous data fetching** for movie data</li><li>Follows **MVVM pattern** for separation of concerns</li></ul> |
| 🔩 | **Code Quality**  | <ul><li>Consistent **Swift coding standards**</li><li>Uses **protocol-oriented programming** for flexibility</li><li>Includes **comments** and **MARK** annotations for clarity</li></ul> |
| 📄 | **Documentation** | <ul><li>Basic **README** with project overview</li><li>In-code **doc comments** for classes and methods</li><li>No extensive external docs or wiki</li></ul> |
| 🔌 | **Integrations**  | <ul><li>Integrates with **The Movie Database (TMDb) API** via **URLSession**</li><li>Uses **JSON parsing** with **Codable**</li><li>Supports **loading JSON configs** for API keys and settings</li></ul> |
| 🧩 | **Modularity**    | <ul><li>Divided into **separate modules**: Network layer, ViewModels, Views</li><li>Uses **protocols** to decouple components</li><li>Supports **easy extension** for additional features</li></ul> |
| 🧪 | **Testing**       | <ul><li>Includes **unit tests** for **NetworkManager** and **ViewModels**</li><li>Uses **XCTest** framework</li><li>Tests focus on **async data fetching** and **error handling**</li></ul> |
| ⚡️  | **Performance**   | <ul><li>Employs **concurrent data loading** to improve UI responsiveness</li><li>Uses **lazy loading** for images and data</li><li>Minimal blocking on main thread</li></ul> |
| 🛡️ | **Security**      | <ul><li>Stores API keys in **loading.json** (not encrypted)</li><li>Uses **HTTPS** for all network requests</li><li>No explicit security features like OAuth or token refresh</li></ul> |
| 📦 | **Dependencies**  | <ul><li>Relies on **Swift** standard libraries</li><li>Uses **loading.json** and **contents.json** for configuration</li><li>Minimal external dependencies, primarily JSON and network handling</li></ul> |

---

## Project Structure

```sh
└── MovieProjectConcurrency/
    ├── App
    │   ├── AppCoordinator.swift
    │   ├── BaseCoordinator.swift
    │   └── DefaultAppScreenFactory.swift
    ├── Features
    │   ├── Home
    │   ├── MovieDetail
    │   └── ViewState.swift
    ├── LICENSE
    ├── MovieProjectConcurrency.xcodeproj
    │   ├── project.pbxproj
    │   └── xcshareddata
    ├── Networking
    │   ├── Environment.swift
    │   ├── NetworkScheduler.swift
    │   ├── Requests
    │   ├── Responses
    │   └── ServiceLayer
    ├── README.md
    └── Resources
        ├── AppDelegate.swift
        ├── Assets.xcassets
        ├── Extensions.swift
        ├── Info.plist
        ├── LoadingView.swift
        ├── SceneDelegate.swift
        └── loading.json
```

---

### Project Index

<details open>
	<summary><b><code>MOVIEPROJECTCONCURRENCY/</code></b></summary>
	<!-- __root__ Submodule -->
	<details>
		<summary><b>__root__</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ __root__</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/LICENSE'>LICENSE</a></b></td>
					<td style='padding: 8px;'>- Provides the licensing information for the project, establishing legal permissions and restrictions<br>- It ensures users understand their rights to use, modify, and distribute the software while clarifying liability limitations<br>- This file underpins the projects open-source distribution, supporting its integration and collaboration within the broader codebase architecture.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/README.md'>README.md</a></b></td>
					<td style='padding: 8px;'>- Provides an overview of the MovieProjectConcurrency, emphasizing its role in demonstrating concurrency management within a hybrid UIKit and SwiftUI environment<br>- It highlights how the project leverages concurrency techniques to enhance user experience and performance, serving as a practical example of integrating modern concurrency practices into a multi-framework iOS application architecture.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- Resources Submodule -->
	<details>
		<summary><b>Resources</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ Resources</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/Extensions.swift'>Extensions.swift</a></b></td>
					<td style='padding: 8px;'>- Provides UI enhancements and utility extensions to streamline user interface management, including loading indicators, color initialization from hex values, and view size measurement<br>- Facilitates seamless integration of SwiftUI views within UIKit controllers, ensuring consistent styling and responsive layouts across the app<br>- Enhances overall user experience by simplifying common UI tasks and maintaining visual consistency.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/AppDelegate.swift'>AppDelegate.swift</a></b></td>
					<td style='padding: 8px;'>- Defines application lifecycle behavior and scene configuration for the MovieProjectConcurrency app, ensuring proper initialization and scene management within the iOS architecture<br>- Facilitates the setup of the app’s main interface and scene delegate linkage, supporting smooth startup and multi-scene handling in alignment with the overall project structure.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/SceneDelegate.swift'>SceneDelegate.swift</a></b></td>
					<td style='padding: 8px;'>- Orchestrates the apps initial user interface setup by configuring the main window, establishing navigation flow, and initiating the primary coordinator<br>- Facilitates seamless transition between screens, such as movie list and detail views, ensuring a structured and maintainable architecture for managing scene lifecycle and navigation within the app.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/LoadingView.swift'>LoadingView.swift</a></b></td>
					<td style='padding: 8px;'>- Provides a reusable animated loading indicator utilizing Lottie animations, integrated seamlessly into the app’s UI<br>- Facilitates user feedback during asynchronous operations by displaying a visually engaging overlay, ensuring smooth transitions and improved user experience across the applications architecture.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/loading.json'>loading.json</a></b></td>
					<td style='padding: 8px;'>- Defines a JSON-based animation resource for a loading indicator, orchestrating layered vector shapes with animated rotations and scaling to create a dynamic visual cue<br>- Integrates seamlessly into the applications architecture to enhance user experience during load times by providing an engaging, animated visual feedback.</td>
				</tr>
			</table>
			<!-- Assets.xcassets Submodule -->
			<details>
				<summary><b>Assets.xcassets</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Resources.Assets.xcassets</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/Assets.xcassets/Contents.json'>Contents.json</a></b></td>
							<td style='padding: 8px;'>- Defines the metadata for the apps asset catalog, specifying authoring details and versioning information<br>- It ensures proper management and organization of visual assets within the project, facilitating seamless asset handling and updates across the applications architecture<br>- This configuration supports consistent asset referencing and integration throughout the development lifecycle.</td>
						</tr>
					</table>
					<!-- searchIcon.imageset Submodule -->
					<details>
						<summary><b>searchIcon.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Resources.Assets.xcassets.searchIcon.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/Assets.xcassets/searchIcon.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines and manages the visual assets for the search icon across multiple device resolutions, ensuring consistent and scalable representation within the app’s user interface<br>- Serves as a key resource for maintaining visual consistency and supporting responsive design in the overall project architecture.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- closeButton.imageset Submodule -->
					<details>
						<summary><b>closeButton.imageset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Resources.Assets.xcassets.closeButton.imageset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/Assets.xcassets/closeButton.imageset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines and manages the visual assets for the close button across multiple device resolutions, ensuring consistent appearance and optimal performance within the applications user interface<br>- Integrates seamlessly into the overall asset management system, supporting a cohesive and scalable design architecture for the apps visual elements.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- AccentColor.colorset Submodule -->
					<details>
						<summary><b>AccentColor.colorset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Resources.Assets.xcassets.AccentColor.colorset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/Assets.xcassets/AccentColor.colorset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines a universal accent color within the app’s asset catalog, ensuring consistent visual styling across different device idioms<br>- Supports the overall design system by centralizing color management, facilitating cohesive user interface aesthetics, and simplifying future updates to the app’s color scheme.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- AppIcon.appiconset Submodule -->
					<details>
						<summary><b>AppIcon.appiconset</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Resources.Assets.xcassets.AppIcon.appiconset</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Resources/Assets.xcassets/AppIcon.appiconset/Contents.json'>Contents.json</a></b></td>
									<td style='padding: 8px;'>- Defines the app icon assets for iOS across various appearances and device sizes, ensuring consistent branding and visual identity in the apps user interface<br>- Integrates seamlessly into the overall project architecture by providing the necessary image resources for different display modes, supporting a polished and adaptable user experience across all iOS devices and themes.</td>
								</tr>
							</table>
						</blockquote>
					</details>
				</blockquote>
			</details>
		</blockquote>
	</details>
	<!-- App Submodule -->
	<details>
		<summary><b>App</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ App</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/App/BaseCoordinator.swift'>BaseCoordinator.swift</a></b></td>
					<td style='padding: 8px;'>- Defines foundational protocols and enums for managing navigation flow within the application<br>- Establishes a structured approach for coordinating screen transitions, including main screens and detail views, while supporting flexible navigation bar styles<br>- Serves as the core architecture component that orchestrates user navigation, ensuring modularity and maintainability across the app’s view hierarchy.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/App/DefaultAppScreenFactory.swift'>DefaultAppScreenFactory.swift</a></b></td>
					<td style='padding: 8px;'>- Defines a factory responsible for creating and configuring main application screens, including movie list and detail views<br>- Facilitates navigation and integrates view models with UI components, supporting seamless screen transitions within the app’s architecture<br>- Serves as a central point for assembling view controllers, ensuring consistency and modularity across the user interface.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/App/AppCoordinator.swift'>AppCoordinator.swift</a></b></td>
					<td style='padding: 8px;'>- Orchestrates navigation flow within the app by managing view controller presentation based on user routes<br>- Facilitates seamless transitions between movie list and detail screens, applying appropriate navigation bar styles and maintaining route context<br>- Serves as the central coordinator ensuring consistent navigation behavior aligned with the apps architecture.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- Networking Submodule -->
	<details>
		<summary><b>Networking</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ Networking</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/NetworkScheduler.swift'>NetworkScheduler.swift</a></b></td>
					<td style='padding: 8px;'>- Provides centralized management of network-related asynchronous tasks within the application, ensuring sequential execution and streamlined cancellation<br>- Facilitates coordinated scheduling of network requests, maintaining task order and enabling efficient termination of ongoing operations, thereby enhancing the robustness and responsiveness of the app’s networking layer.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Environment.swift'>Environment.swift</a></b></td>
					<td style='padding: 8px;'>- Defines environment-specific configuration by sourcing API base URL and API key from the apps Info.plist, enabling dynamic setup for different deployment environments within the MovieProjectConcurrency architecture<br>- Facilitates centralized management of essential network parameters, ensuring secure and flexible API interactions across development, staging, and production setups.</td>
				</tr>
			</table>
			<!-- Responses Submodule -->
			<details>
				<summary><b>Responses</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Networking.Responses</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Responses/MovieModel.swift'>MovieModel.swift</a></b></td>
							<td style='padding: 8px;'>- Defines data models for parsing and representing movie data retrieved from an external API, facilitating seamless integration of movie information within the applications architecture<br>- These models enable efficient decoding of API responses and support features like displaying movie details, images, and release dates across the apps user interface.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Responses/SearchModel.swift'>SearchModel.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the data structure for handling search results within the movie application, encapsulating pagination details and a list of movies<br>- Facilitates seamless decoding of API responses related to search queries, integrating search functionality into the overall app architecture for efficient data retrieval and presentation.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Responses/SimilarMoviesModel.swift'>SimilarMoviesModel.swift</a></b></td>
							<td style='padding: 8px;'>- Defines data models for fetching and representing similar movies from an external API, facilitating seamless decoding of API responses<br>- Integrates into the broader architecture by enabling the application to display related movie suggestions, enhancing user experience through dynamic content retrieval and presentation within the movie browsing ecosystem.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Responses/MovieDetailModel.swift'>MovieDetailModel.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the data model for detailed movie information within the application, enabling seamless decoding of API responses and consistent data handling<br>- Facilitates the integration of movie details such as title, overview, release date, and imagery, supporting the overall architectures focus on efficient data retrieval and presentation in the movie browsing experience.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- Requests Submodule -->
			<details>
				<summary><b>Requests</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Networking.Requests</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Requests/GetMovieDetailRequest.swift'>GetMovieDetailRequest.swift</a></b></td>
							<td style='padding: 8px;'>- Defines a network request to retrieve detailed information about a specific movie by its ID, integrating seamlessly into the overall API communication layer<br>- Facilitates fetching comprehensive movie data, supporting features like movie detail display and user interactions within the application’s architecture<br>- Ensures consistent request structure aligned with the project’s API interaction standards.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Requests/GetUpcomingListRequest.swift'>GetUpcomingListRequest.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the network request for retrieving upcoming movies from the API, encapsulating endpoint details, query parameters, and response handling<br>- Integrates seamlessly into the broader architecture to facilitate asynchronous data fetching, supporting the apps functionality to display current and future movie releases efficiently.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Requests/GetNowPlayingListRequest.swift'>GetNowPlayingListRequest.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the network request for retrieving the list of currently playing movies from the API, integrating seamlessly into the app’s data fetching layer<br>- It facilitates communication with the backend service, enabling the app to display up-to-date movie information within the overall architecture<br>- This request supports dynamic data updates and enhances user engagement through real-time content.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Requests/GetSearchResultsRequest.swift'>GetSearchResultsRequest.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the network request for retrieving movie search results, encapsulating query parameters, endpoint details, and response handling within the overall API architecture<br>- Facilitates seamless integration of search functionality by standardizing how search queries are constructed and executed, supporting the app’s core feature of fetching and displaying movie data based on user input.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/Requests/GetSimilarMoviesRequest.swift'>GetSimilarMoviesRequest.swift</a></b></td>
							<td style='padding: 8px;'>- Defines a network request to fetch similar movies based on a specified movie ID, integrating with the overall API architecture<br>- Facilitates retrieving paginated recommendations, enabling dynamic content updates within the app’s movie browsing experience<br>- Serves as a key component for expanding movie details with related suggestions, supporting seamless data flow in the project’s networking layer.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- ServiceLayer Submodule -->
			<details>
				<summary><b>ServiceLayer</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Networking.ServiceLayer</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/ServiceLayer/ServiceLayer.swift'>ServiceLayer.swift</a></b></td>
							<td style='padding: 8px;'>- Facilitates network communication within the architecture by managing API requests and responses asynchronously<br>- Handles request execution, response decoding, and error management, ensuring reliable data exchange between the app and external services<br>- Serves as a core component for integrating backend APIs, supporting robust and scalable network operations across the project.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Networking/ServiceLayer/ApiRequest.swift'>ApiRequest.swift</a></b></td>
							<td style='padding: 8px;'>- Defines a standardized interface for constructing and configuring API requests within the project’s networking layer<br>- Facilitates seamless creation of URL requests by managing endpoints, query parameters, headers, and HTTP methods, ensuring consistent and flexible communication with backend services across the applications architecture.</td>
						</tr>
					</table>
				</blockquote>
			</details>
		</blockquote>
	</details>
	<!-- Features Submodule -->
	<details>
		<summary><b>Features</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ Features</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/ViewState.swift'>ViewState.swift</a></b></td>
					<td style='padding: 8px;'>- Defines the various states of the user interface within the MovieProjectConcurrency application, facilitating seamless state management during data loading, success, or error scenarios<br>- Serves as a core component for orchestrating UI updates based on asynchronous operations, ensuring a consistent and predictable user experience across the app’s architecture.</td>
				</tr>
			</table>
			<!-- Home Submodule -->
			<details>
				<summary><b>Home</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Features.Home</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeViewModelProtocol.swift'>HomeViewModelProtocol.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the contract for the Home screens view model, orchestrating movie data management and user interactions<br>- It facilitates fetching and displaying now playing, upcoming, and search result movies, while handling user navigation, screen lifecycle events, and pagination<br>- This protocol ensures a consistent interface for implementing the core logic that drives the Home feature within the apps architecture.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeViewController.swift'>HomeViewController.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the main interface for the home screen, serving as the entry point for user interaction within the app<br>- It orchestrates the presentation of movie-related content by connecting the user interface with the underlying view model, facilitating data flow and user engagement in the overall architecture of the movie browsing experience.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeView.swift'>HomeView.swift</a></b></td>
							<td style='padding: 8px;'>- Provides the main user interface for the home screen, displaying movie content including a carousel of now-playing movies and a list of upcoming movies<br>- Manages view states, handles user interactions such as search and navigation, and integrates with view model logic to load and refresh movie data dynamically within the app’s architecture.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeViewModel.swift'>HomeViewModel.swift</a></b></td>
							<td style='padding: 8px;'>- Manages the home screens state by fetching and displaying current and upcoming movies, handling user search queries with debounce, and supporting pagination for seamless content loading<br>- Facilitates navigation to movie details and ensures smooth data updates, integrating network operations within the overall app architecture to deliver an engaging, responsive movie browsing experience.</td>
						</tr>
					</table>
					<!-- HomeDataController Submodule -->
					<details>
						<summary><b>HomeDataController</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Features.Home.HomeDataController</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeDataController/HomeDataProtocol.swift'>HomeDataProtocol.swift</a></b></td>
									<td style='padding: 8px;'>- Defines a protocol for fetching and searching movie data within the applications architecture<br>- It standardizes asynchronous data retrieval for now playing, upcoming, and search results, facilitating seamless integration and data flow between the user interface and data sources in the movie app<br>- This protocol underpins the data layer, ensuring consistent and testable interactions with movie-related data.</td>
								</tr>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeDataController/HomeDataController.swift'>HomeDataController.swift</a></b></td>
									<td style='padding: 8px;'>- Provides an abstraction layer for fetching movie data within the application architecture<br>- It coordinates with the service layer to retrieve current now-playing movies, upcoming releases, and search results, facilitating seamless data flow between the network API and the user interface<br>- This component centralizes data retrieval logic, supporting the app’s modular and scalable design.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- HomeTests Submodule -->
					<details>
						<summary><b>HomeTests</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Features.Home.HomeTests</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeTests/HomeViewModelTests.swift'>HomeViewModelTests.swift</a></b></td>
									<td style='padding: 8px;'>- Provides comprehensive unit tests for the HomeViewModel, ensuring reliable management of movie data, state transitions, and navigation within the applications architecture<br>- Validates core functionalities such as data loading, error handling, pagination, and search filtering, thereby safeguarding the integrity of the user interface layer and supporting seamless user interactions in the overall movie app ecosystem.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- HomeViews Submodule -->
					<details>
						<summary><b>HomeViews</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Features.Home.HomeViews</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeViews/CarouselView.swift'>CarouselView.swift</a></b></td>
									<td style='padding: 8px;'>- Provides a swipeable carousel interface for displaying a list of movies, showcasing key details such as titles, release years, and overviews with visually appealing gradients and images<br>- Facilitates user interaction by enabling selection of individual movies, integrating seamlessly into the app’s overall architecture to enhance browsing and discovery experiences within the movie exploration feature.</td>
								</tr>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/Home/HomeViews/SearchView.swift'>SearchView.swift</a></b></td>
									<td style='padding: 8px;'>- Provides an interactive search interface for movies, enabling users to input queries and view real-time search results with images and titles<br>- Facilitates seamless selection of movies from the results, integrating with the broader application to support dynamic content filtering and navigation within the movie browsing experience<br>- Enhances user engagement through smooth animations and responsive UI elements.</td>
								</tr>
							</table>
						</blockquote>
					</details>
				</blockquote>
			</details>
			<!-- MovieDetail Submodule -->
			<details>
				<summary><b>MovieDetail</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ Features.MovieDetail</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailViewModelProtocol.swift'>MovieDetailViewModelProtocol.swift</a></b></td>
							<td style='padding: 8px;'>- Defines a protocol for managing the state and data flow of the Movie Detail screen within the application<br>- It facilitates handling movie details, similar movies, and view lifecycle events, ensuring a consistent interface for view model implementations<br>- This protocol supports the overall architecture by promoting separation of concerns and enabling reactive UI updates in the movie detail feature.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailViewModel.swift'>MovieDetailViewModel.swift</a></b></td>
							<td style='padding: 8px;'>- Provides the core logic for managing movie detail data and related UI states within the application<br>- It orchestrates fetching detailed information and similar movies asynchronously, updating the view state accordingly, and handles lifecycle events to ensure efficient data loading and task management<br>- This component is essential for delivering a responsive and dynamic movie detail experience in the app.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailViewController.swift'>MovieDetailViewController.swift</a></b></td>
							<td style='padding: 8px;'>- Defines the user interface for displaying detailed information about a selected movie within the application<br>- Integrates with the view model to present relevant data, supporting seamless navigation and user experience in the movie browsing flow<br>- Serves as a key component in the architecture that manages presentation logic for movie details in the overall project.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailView.swift'>MovieDetailView.swift</a></b></td>
							<td style='padding: 8px;'>- Provides the user interface for displaying detailed information about a selected movie, managing different view states such as loading, loaded, and error<br>- Integrates with a view model to fetch and present movie data, utilizing a parallax effect for visual appeal<br>- Serves as a key component in the app’s architecture for delivering an engaging, dynamic movie detail experience.</td>
						</tr>
					</table>
					<!-- MovieDetailTests Submodule -->
					<details>
						<summary><b>MovieDetailTests</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Features.MovieDetail.MovieDetailTests</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailTests/MovieDetailViewModelTests.swift'>MovieDetailViewModelTests.swift</a></b></td>
									<td style='padding: 8px;'>- Provides comprehensive unit tests for the MovieDetailViewModel, ensuring correct data loading, state management, and error handling within the movie detail feature<br>- Validates interactions with the data controller and verifies that the view model updates its state appropriately during various scenarios, supporting robust and reliable user interface behavior in the overall application architecture.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- MovieDetailViews Submodule -->
					<details>
						<summary><b>MovieDetailViews</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Features.MovieDetail.MovieDetailViews</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailViews/ParallaxView.swift'>ParallaxView.swift</a></b></td>
									<td style='padding: 8px;'>- Implements a dynamic, visually engaging parallax header for movie detail screens, enhancing user experience through smooth scrolling and image transitions<br>- It seamlessly integrates with the overall architecture by providing an immersive, responsive interface that highlights movie visuals and details, contributing to a cohesive and polished presentation within the apps feature set.</td>
								</tr>
							</table>
						</blockquote>
					</details>
					<!-- MovieDetailDataController Submodule -->
					<details>
						<summary><b>MovieDetailDataController</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ Features.MovieDetail.MovieDetailDataController</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailDataController/MovieDetailDataProtocol.swift'>MovieDetailDataProtocol.swift</a></b></td>
									<td style='padding: 8px;'>- Defines a protocol for fetching movie details and similar movies asynchronously, facilitating data retrieval within the MovieDetail feature<br>- It standardizes how movie information and related content are accessed, supporting seamless integration and data flow in the applications architecture<br>- This protocol enables consistent data operations across different implementations, ensuring modularity and testability.</td>
								</tr>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/master/Features/MovieDetail/MovieDetailDataController/MovieDetailDataController.swift'>MovieDetailDataController.swift</a></b></td>
									<td style='padding: 8px;'>- Facilitates retrieval of detailed movie information and related content within the application architecture<br>- Acts as an intermediary layer that communicates with the API service to fetch specific movie details and similar movies, supporting the presentation layer with necessary data for displaying comprehensive movie insights and recommendations<br>- Ensures seamless data flow between the user interface and backend services.</td>
								</tr>
							</table>
						</blockquote>
					</details>
				</blockquote>
			</details>
		</blockquote>
	</details>
</details>

---

## Getting Started

### Prerequisites

This project requires the following dependencies:

- **Programming Language:** Swift
- **Package Manager:** Swift_package_manager

### Installation

Build MovieProjectConcurrency from the source and install dependencies:

1. **Clone the repository:**

    ```sh
    ❯ git clone https://github.com/cagatayegilmez/MovieProjectConcurrency
    ```

2. **Navigate to the project directory:**

    ```sh
    ❯ cd MovieProjectConcurrency
    ```

3. **Install the dependencies:**

**Using [swift_package_manager](https://swift.org/):**

```sh
❯ swift build
```

### Usage

Run the project with:

**Using [swift_package_manager](https://swift.org/):**

```sh
swift run
```

### Testing

Movieprojectconcurrency uses the {__test_framework__} test framework. Run the test suite with:

**Using [swift_package_manager](https://swift.org/):**

```sh
swift test
```

---

## Roadmap

- [X] **`Task 1`**: <strike>Implement feature one.</strike>
- [ ] **`Task 2`**: Implement feature two.
- [ ] **`Task 3`**: Implement feature three.

---

## Contributing

- **💬 [Join the Discussions](https://github.com/cagatayegilmez/MovieProjectConcurrency/discussions)**: Share your insights, provide feedback, or ask questions.
- **🐛 [Report Issues](https://github.com/cagatayegilmez/MovieProjectConcurrency/issues)**: Submit bugs found or log feature requests for the `MovieProjectConcurrency` project.
- **💡 [Submit Pull Requests](https://github.com/cagatayegilmez/MovieProjectConcurrency/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/cagatayegilmez/MovieProjectConcurrency
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="left">
   <a href="https://github.com{/cagatayegilmez/MovieProjectConcurrency/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=cagatayegilmez/MovieProjectConcurrency">
   </a>
</p>
</details>

---

## License

Movieprojectconcurrency is protected under the [LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

## Acknowledgments

- Credit `contributors`, `inspiration`, `references`, etc.

<div align="left"><a href="#top">⬆ Return</a></div>

---
