---
description: Setup Windows Development Environment for Flutter
---

To run Flutter apps on Windows Desktop, you need the **Visual Studio** toolchain (not just VS Code).

### 1. Download Visual Studio 2022
Visit the [Visual Studio downloads page](https://visualstudio.microsoft.com/downloads/) and download **Visual Studio Community 2022** (it's free).

### 2. Install the C++ Workload
1. Run the installer.
2. When asked to choose workloads, select **"Desktop development with C++"**.
3. Ensure the following components are selected (usually selected by default):
   - MSVC v143 - VS 2022 C++ x64/x86 build tools
   - Windows 10/11 SDK

### 3. Finish Installation
Click **Install** and wait for it to finish. You may need to reboot your computer.

### 4. Verify
After installation, run `flutter doctor` again to confirm the issue is resolved.
