> `(This entire document is human written by me @llamathehutt)`

# lynis-security
Security Hardening for Ubuntu based on Lynis Audits

Run the `interactive-cli_ubuntu.bash` script and feel free to apply any of the audit suggestions from Lynis into your Ubuntu system.

If you found these scripts saving you time, please star this project. Enjoy!

# Notes

For Linux users with Nvidia drivers, by default the Secure Boot BIOS feature will prevent Nvidia drivers from being read even if it's been installed via for example, the Driver Manager in Linux Mint, because the Nvidia drivers have not been signed.

Therefore I prompted `Claude Sonnet 4.5` to create a script that automates the driver signing procedure via MOK. I ran it and it works flawlessly from my experience on `Linux Mint 22.1`.

To do this, use the generated script located in `./utilities` folder and get the file `nvidia-sign-drivers.bash`.

You can find generated info and instructions on this bash script in the same folder `./utilities/nvidia-sign-drivers.md`.

The point of this script is to cope Nvidia drivers to work with the BIOS feature "Secure Boot". Linux users with AMD graphics drivers avoid this procedure due to AMD GPU drivers being signed out of the box.
