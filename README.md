# FIXIT 2.1.2

![FIXIT Banner](https://user-images.githubusercontent.com/57842821/209219699-82159c0b-37a2-4084-ba1f-cb823b010013.png)

## Overview

FIXIT is a lightweight and user-friendly tool designed to optimize and repair Windows operating systems. It provides direct access to system tools and elements, making it easy to perform repairs and enhancements. The project is open-source under the MIT license and primarily targets Windows 10 and later versions, with some functionalities tested on Windows 7 and above.

## Features

- **fixit.bat**: The main tool for system repair and optimization.
- **packet_handler.bat**: Facilitates access to system tools and enhances system functionality.

## How to Use

1. Clone or download the repository to your local machine.
2. Open Command Prompt as an administrator.
3. Navigate to the directory where FIXIT is located.
4. Run `fixit.bat` or `packet_handler.bat` based on your needs.
5. Follow the on-screen menu to select and execute desired actions.

**if you need help use follow command: `fixit.bat` or `packet_handler.bat` -help**

## Menu Structure

### FIXIT
- **AUTO**
  - Quick Repair
  - Quick Clean
  - Scheduled Tasks
    - Repair System Monthly
    - Clean The System Monthly
- **ADVANCED**
  - System Tools
    - System file check
    - Check repair files
    - System Image Restore
    - Analysis of the data structure on disk (reboot required)
    - Convert MBR Disk to GPT (Not Recommended)
    - Force System Updates
    - Defrag Main drive
  - Web Tools
    - Internal DNS cleanup
    - DNS testing
    - Internal DNS selector
    - View WiFi Password
  - Clean Tools
    - System Cleanup
    - Custom Cleanup
    - Clean Windows Defender
    - Clear Recent Files List

### Packet Handler
- System Tools Shortcuts (19 shortcuts available)
- Process and Services
  - Stop Unnecessary Services
  - Stop Xbox Services
  - Recover Deleted Files
  - Disable Telemetry Collection
  - Disable Automatic Updates (Windows Update)
  - Activate Automatic Updates (Windows Update)
- System Settings
  - Activate Old Photo Viewer
  - Add security layer against Malware Execution
  - Remove security layer against Malware Execution
  - Remove the New Menu Design from Windows 11
  - Return to the New Windows 11 Menu Design
  - Disable All Web Extensions (Chrome and Edge)
  - Disable Execution of Unsigned PS Scripts
  - EXTRA settings
- Packages
  - Uninstall a Third-Party Application
  - Uninstall Windows Apps
  - Uninstall Microsoft Office
  - Uninstall OneDrive
  - Install All WindowsApps
  - Install Selection of WindowsApps
  - Install HEVC (H.265) Video Codec
  - Install Office 2021 (without license)
  - PowerToys
  - Update All Apps
- Debloat (remove all unnecessary packages that Windows installs by default)

## Contributing

Feel free to contribute to FIXIT by submitting pull requests or reporting issues on the GitHub repository.

## License

FIXIT is licensed under the MIT License. See [LICENSE](LICENSE) for more details.
