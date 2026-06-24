<div align="center">
  <img src="https://user-images.githubusercontent.com/16918590/111069765-ee119500-8511-11eb-83c2-a45bf2aa40da.png" width="196px" />
  <h1>Fuwari-Secure</h1>
</div>

<div align="center">
<a href="https://github.com/tnaoyak/Fuwari-Secure/releases/latest"><img src="https://img.shields.io/github/release/tnaoyak/Fuwari-Secure.svg" alt="Release version"></a>
<a href="https://github.com/tnaoyak/Fuwari-Secure/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License: MIT"></a>
</div>

<br>

<div align="center">
  <strong>Floating screenshot like a sticky (Secure Edition).</strong>
</div>

Fuwari-Secure is a secure fork of Fuwari, designed for strict enterprise security environments. All external upload features (including Gyazo upload and OAuth integration) have been completely removed to ensure no data leaves your local machine.

## Demo

<p align="center" >
<img src="https://fuwari-app.com/images/fuwari_demo_1.0.0.gif" width="720px" />
</p>

## Installation & Usage

Since Fuwari-Secure is distributed outside the Mac App Store as a secure standalone app, please follow these steps to install and open it:

### Homebrew

You can install Fuwari-Secure via Homebrew using the custom tap:

```bash
brew install tnaoyak/tap/fuwari-secure
```

If you see a security warning or a message saying "Fuwari-Secure is damaged and cannot be opened" after installing via Homebrew, please run the following command to remove the quarantine attribute:

```bash
xattr -cr /Applications/Fuwari-Secure.app
```

### Manual Installation

1. **Download**: Go to the [Releases](https://github.com/tnaoyak/Fuwari-Secure/releases) page and download the latest `Fuwari.dmg` file.
2. **Install**: Double-click the downloaded `.dmg` file and drag `Fuwari-Secure.app` into your **Applications** folder.
3. **Open (Gatekeeper Bypass)**:
   * Because the app is self-signed, double-clicking it normally will show a security warning: *"Fuwari-Secure cannot be opened because the developer cannot be verified."*
   * **To bypass this**: Right-click (or hold the `Control` key and click) `Fuwari-Secure.app` in your Applications folder, select **Open** from the menu, and then click **Open** again in the confirmation dialog. This is only required for the first launch.

### Troubleshooting: "Fuwari-Secure is damaged and cannot be opened"

If you see a dialog saying *"Fuwari-Secure is damaged and cannot be opened. You should move it to the Trash."*, this is a known macOS security behavior for downloaded self-signed apps. The app is **not** damaged. 

To fix this, you will need to remove the macOS quarantine attribute using the Terminal:

1. Open the **Terminal** app on your Mac (you can find it via Spotlight search by pressing `Cmd + Space` and typing "Terminal").
2. Copy and paste the following command, then press `Enter`:
   ```bash
   xattr -cr /Applications/Fuwari-Secure.app
   ```
3. Close the Terminal and open `Fuwari-Secure.app` again. It will now launch perfectly!

## Features

* [x] **Keep a screenshot on your screen**
  * [x] Position and Display size can be freely changeable.
  * [x] Change the transparency freely with the mouse wheel.
  * [x] Change the display range in the space.
  * [x] Can be copied to clipboard.
  * [x] Of course, can be save.

## Requirements

* Swift 5+
* Xcode 13.4+
* macOS 11.0+

## Contributing

1. Fork it ( <https://github.com/tnaoyak/Fuwari-Secure/fork> )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The MIT License (MIT)

* Copyright (c) 2016 Kengo YOKOYAMA

## Author

* [kentya6](https://github.com/kentya6) (Original Author)
* [tnaoyak](https://github.com/tnaoyak) (Secure Fork Maintainer)
