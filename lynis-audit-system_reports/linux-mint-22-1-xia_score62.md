[ Lynis 3.1.6 ]

################################################################################
  Lynis comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
  welcome to redistribute it under the terms of the GNU General Public License.
  See the LICENSE file for details about using this software.

  2007-2025, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)
################################################################################


[+] Initializing program
------------------------------------

  ###################################################################
  #                                                                 #
  #   NON-PRIVILEGED SCAN MODE                                      #
  #                                                                 #
  ###################################################################

  NOTES:
  --------------
  * Some tests will be skipped (as they require root permissions)
  * Some tests might fail silently or give different results

  - Detecting OS...                                           [ DONE ]
  - Checking profiles...                                      [ DONE ]

  ---------------------------------------------------
  Program version:           3.1.6
  Operating system:          Linux
  Operating system name:     Linux Mint
  Operating system version:  22.1
  End-of-life:               NO
  Kernel version:            6.8.0
  Hardware platform:         x86_64
  Hostname:                  716IRX8
  ---------------------------------------------------
  Profiles:                  /etc/lynis/default.prf
  Log file:                  /home/llamathehutt/lynis.log
  Report file:               /home/llamathehutt/lynis-report.dat
  Report version:            1.0
  Plugin directory:          /usr/share/lynis/plugins
  ---------------------------------------------------
  Auditor:                   [Not Specified]
  Language:                  en
  Test category:             all
  Test group:                all
  ---------------------------------------------------
  - Program update status...                                  [ NO UPDATE ]

[+] System tools
------------------------------------
  - Scanning available tools...
  - Checking system binaries...

[+] Plugins (phase 1)
------------------------------------
 Note: plugins have more extensive tests and may take several minutes to complete
  
  - Plugins enabled                                           [ NONE ]

[+] Boot and services
------------------------------------
  - Service Manager                                           [ systemd ]
  - Checking presence GRUB2                                   [ FOUND ]
    - Checking for password protection                        [ NONE ]
  - Check running services (systemctl)                        [ DONE ]
        Result: found 38 running services
  - Check enabled services at boot (systemctl)                [ DONE ]
        Result: found 56 enabled services
  - Check startup files (permissions)                         [ OK ]
  - Running 'systemd-analyze security'
      Unit name (exposure value) and predicate
      --------------------------------
    - ModemManager.service (value=6.3)                        [ MEDIUM ]
    - NetworkManager.service (value=7.8)                      [ EXPOSED ]
    - accounts-daemon.service (value=5.5)                     [ MEDIUM ]
    - alsa-state.service (value=9.6)                          [ UNSAFE ]
    - anacron.service (value=9.6)                             [ UNSAFE ]
    - avahi-daemon.service (value=9.6)                        [ UNSAFE ]
    - blueman-mechanism.service (value=9.6)                   [ UNSAFE ]
    - bluetooth.service (value=6.0)                           [ MEDIUM ]
    - colord.service (value=3.5)                              [ PROTECTED ]
    - containerd.service (value=9.6)                          [ UNSAFE ]
    - cron.service (value=9.6)                                [ UNSAFE ]
    - cups-browsed.service (value=9.3)                        [ UNSAFE ]
    - cups.service (value=9.6)                                [ UNSAFE ]
    - dbus.service (value=9.5)                                [ UNSAFE ]
    - dm-event.service (value=9.5)                            [ UNSAFE ]
    - dmesg.service (value=9.6)                               [ UNSAFE ]
    - docker.service (value=9.6)                              [ UNSAFE ]
    - emergency.service (value=9.5)                           [ UNSAFE ]
    - flatpak-system-helper.service (value=9.6)               [ UNSAFE ]
    - getty@tty1.service (value=9.6)                          [ UNSAFE ]
    - getty@tty7.service (value=9.6)                          [ UNSAFE ]
    - gnome-remote-desktop.service (value=9.2)                [ UNSAFE ]
    - irqbalance.service (value=8.9)                          [ EXPOSED ]
    - kerneloops.service (value=9.2)                          [ UNSAFE ]
    - lightdm.service (value=9.6)                             [ UNSAFE ]
    - lvm2-lvmpolld.service (value=9.5)                       [ UNSAFE ]
    - mintsystem.service (value=9.6)                          [ UNSAFE ]
    - networkd-dispatcher.service (value=9.6)                 [ UNSAFE ]
    - nvidia-persistenced.service (value=9.6)                 [ UNSAFE ]
    - packagekit.service (value=9.6)                          [ UNSAFE ]
    - plymouth-halt.service (value=9.5)                       [ UNSAFE ]
    - plymouth-poweroff.service (value=9.5)                   [ UNSAFE ]
    - plymouth-reboot.service (value=9.5)                     [ UNSAFE ]
    - plymouth-start.service (value=9.5)                      [ UNSAFE ]
    - polkit.service (value=1.6)                              [ PROTECTED ]
    - power-profiles-daemon.service (value=5.1)               [ MEDIUM ]
    - rc-local.service (value=9.6)                            [ UNSAFE ]
    - rescue.service (value=9.5)                              [ UNSAFE ]
    - rsyslog.service (value=6.3)                             [ MEDIUM ]
    - rtkit-daemon.service (value=7.2)                        [ MEDIUM ]
    - smartmontools.service (value=9.6)                       [ UNSAFE ]
    - ssh.service (value=9.6)                                 [ UNSAFE ]
    - switcheroo-control.service (value=7.6)                  [ EXPOSED ]
    - systemd-ask-password-console.service (value=9.4)        [ UNSAFE ]
    - systemd-ask-password-plymouth.service (value=9.5)       [ UNSAFE ]
    - systemd-ask-password-wall.service (value=9.4)           [ UNSAFE ]
    - systemd-bsod.service (value=9.5)                        [ UNSAFE ]
    - systemd-fsckd.service (value=9.5)                       [ UNSAFE ]
    - systemd-initctl.service (value=9.4)                     [ UNSAFE ]
    - systemd-journald.service (value=4.3)                    [ PROTECTED ]
    - systemd-localed.service (value=1.0)                     [ PROTECTED ]
    - systemd-logind.service (value=2.8)                      [ PROTECTED ]
    - systemd-networkd.service (value=2.6)                    [ PROTECTED ]
    - systemd-resolved.service (value=2.2)                    [ PROTECTED ]
    - systemd-rfkill.service (value=9.4)                      [ UNSAFE ]
    - systemd-timesyncd.service (value=2.1)                   [ PROTECTED ]
    - systemd-udevd.service (value=7.1)                       [ MEDIUM ]
    - thermald.service (value=9.6)                            [ UNSAFE ]
    - touchegg.service (value=9.6)                            [ UNSAFE ]
    - tpm-udev.service (value=9.6)                            [ UNSAFE ]
    - udisks2.service (value=9.6)                             [ UNSAFE ]
    - upower.service (value=2.4)                              [ PROTECTED ]
    - user@1000.service (value=9.4)                           [ UNSAFE ]
    - uuidd.service (value=5.8)                               [ MEDIUM ]
    - whoopsie.service (value=9.6)                            [ UNSAFE ]
    - wpa_supplicant.service (value=9.6)                      [ UNSAFE ]

[+] Kernel
------------------------------------
  - Checking default runlevel                                 [ runlevel 5 ]
  - Checking CPU support (NX/PAE)
    CPU support: PAE and/or NoeXecute supported               [ FOUND ]
  - Checking kernel version and release                       [ DONE ]
  - Checking kernel type                                      [ DONE ]
  - Checking loaded kernel modules                            [ DONE ]
      Found 239 active modules
  - Checking Linux kernel configuration file                  [ FOUND ]
  - Checking default I/O kernel scheduler                     [ NOT FOUND ]
  - Checking for available kernel update                      [ OK ]
  - Checking core dumps configuration
    - configuration in systemd conf files                     [ DEFAULT ]
    - configuration in /etc/profile                           [ DEFAULT ]
    - 'hard' configuration in /etc/security/limits.conf       [ DEFAULT ]
    - 'soft' configuration in /etc/security/limits.conf       [ DEFAULT ]
    - Checking setuid core dumps configuration                [ PROTECTED ]
  - Check if reboot is needed                                 [ NO ]

[+] Memory and Processes
------------------------------------
  - Checking /proc/meminfo                                    [ FOUND ]
  - Searching for dead/zombie processes                       [ FOUND ]
  - Searching for IO waiting processes                        [ NOT FOUND ]
  - Search prelink tooling                                    [ NOT FOUND ]

[+] Users, Groups and Authentication
------------------------------------
  - Administrator accounts                                    [ OK ]
  - Unique UIDs                                               [ OK ]
  - Unique group IDs                                          [ OK ]
  - Unique group names                                        [ OK ]
  - Password file consistency                                 [ SUGGESTION ]
  - Checking password hashing rounds                          [ DISABLED ]
  - Query system users (non daemons)                          [ DONE ]
  - NIS+ authentication support                               [ NOT ENABLED ]
  - NIS authentication support                                [ NOT ENABLED ]
  - Sudoers file(s)                                           [ FOUND ]
  - PAM password strength tools                               [ SUGGESTION ]
  - PAM configuration files (pam.conf)                        [ FOUND ]
  - PAM configuration files (pam.d)                           [ FOUND ]
  - PAM modules                                               [ FOUND ]
  - LDAP module in PAM                                        [ NOT FOUND ]
  - Accounts without expire date                              [ OK ]
  - Accounts without password                                 [ OK ]
  - Locked accounts                                           [ OK ]
  - Checking user password aging (minimum)                    [ DISABLED ]
  - User password aging (maximum)                             [ DISABLED ]
  - Checking Linux single user mode authentication            [ OK ]
  - Determining default umask
    - umask (/etc/profile)                                    [ NOT FOUND ]
    - umask (/etc/login.defs)                                 [ SUGGESTION ]
  - LDAP authentication support                               [ NOT ENABLED ]
  - Logging failed login attempts                             [ ENABLED ]

[+] Kerberos
------------------------------------
  - Check for Kerberos KDC and principals                     [ NOT FOUND ]

[+] Shells
------------------------------------
  - Checking shells from /etc/shells
    Result: found 7 shells (valid shells: 7).
    - Session timeout settings/tools                          [ NONE ]
  - Checking default umask values
    - Checking default umask in /etc/bash.bashrc              [ NONE ]
    - Checking default umask in /etc/profile                  [ NONE ]

[+] File systems
------------------------------------
  - Checking mount points
    - Checking /home mount point                              [ SUGGESTION ]
    - Checking /tmp mount point                               [ SUGGESTION ]
    - Checking /var mount point                               [ SUGGESTION ]
  - Query swap partitions (fstab)                             [ OK ]
  - Testing swap partitions                                   [ OK ]
  - Testing /proc mount (hidepid)                             [ SUGGESTION ]
  - Checking for old files in /tmp                            [ OK ]
  - Checking /tmp sticky bit                                  [ OK ]
  - Checking /var/tmp sticky bit                              [ OK ]
  - Mount options of /                                        [ NON DEFAULT ]
  - Mount options of /boot                                    [ DEFAULT ]
  - Mount options of /dev                                     [ PARTIALLY HARDENED ]
  - Mount options of /dev/shm                                 [ PARTIALLY HARDENED ]
  - Mount options of /run                                     [ HARDENED ]
  - Total without nodev:18 noexec:23 nosuid:16 ro or noexec (W^X): 23 of total 39
  - Checking Locate database                                  [ FOUND ]
  - Disable kernel support of some filesystems

[+] USB Devices
------------------------------------
  - Checking usb-storage driver (modprobe config)             [ NOT DISABLED ]
  - Checking USB devices authorization                        [ ENABLED ]
  - Checking USBGuard                                         [ NOT FOUND ]

[+] Storage
------------------------------------
  - Checking firewire ohci driver (modprobe config)           [ DISABLED ]

[+] NFS
------------------------------------
  - Check running NFS daemon                                  [ NOT FOUND ]

[+] Name services
------------------------------------
  - Searching DNS domain name                                 [ UNKNOWN ]
  - Checking /etc/hosts
    - Duplicate entries in hosts file                         [ NONE ]
    - Presence of configured hostname in /etc/hosts           [ FOUND ]
    - Hostname mapped to localhost                            [ NOT FOUND ]
    - Localhost mapping to IP address                         [ OK ]

[+] Ports and packages
------------------------------------
  - Searching package managers

  [WARNING]: Test NAME-4408 had a long execution: 10.129733 seconds

    - Searching dpkg package manager                          [ FOUND ]
      - Querying package manager

  [WARNING]: Test PKGS-7345 had a long execution: 14.593113 seconds

    - Query unpurged packages                                 [ FOUND ]
  - Checking security repository in sources.list.d directory  [ OK ]
  - Checking upgradeable packages                             [ SKIPPED ]
  - Checking package audit tool                               [ NONE ]
  - Toolkit for automatic upgrades                            [ NOT FOUND ]

[+] Networking
------------------------------------
  - Checking IPv6 configuration                               [ ENABLED ]
      Configuration method                                    [ AUTO ]
      IPv6 only                                               [ NO ]
  - Checking configured nameservers
    - Testing nameservers
        Nameserver: 8.8.8.8                                   [ NO RESPONSE ]
        Nameserver: 1.1.1.1                                   [ NO RESPONSE ]
    - Minimal of 2 responsive nameservers                     [ WARNING ]
    - DNSSEC supported (systemd-resolved)                     [ UNKNOWN ]
  - Checking default gateway                                  [ DONE ]
  - Getting listening ports (TCP/UDP)                         [ DONE ]
  - Checking promiscuous interfaces                           [ OK ]
  - Checking waiting connections                              [ OK ]
  - Checking status DHCP client                               [ NOT ACTIVE ]
  - Checking for ARP monitoring software                      [ NOT FOUND ]
  - Uncommon network protocols                                [ 0 ]

[+] Printers and Spools
------------------------------------
  - Checking cups daemon                                      [ RUNNING ]
  - Checking CUPS configuration file                          [ OK ]
    - File permissions                                        [ WARNING ]
  - Checking CUPS addresses/sockets                           [ FOUND ]
  - Checking lp daemon                                        [ NOT RUNNING ]

[+] Software: e-mail and messaging
------------------------------------

[+] Software: firewalls
------------------------------------
  - Checking iptables kernel module                           [ FOUND ]
  - Checking host based firewall                              [ ACTIVE ]

[+] Software: webserver
------------------------------------
  - Checking Apache                                           [ NOT FOUND ]
  - Checking nginx                                            [ FOUND ]
  - Searching nginx configuration file                        [ NOT FOUND ]

[+] SSH Support
------------------------------------
  - Checking running SSH daemon                               [ FOUND ]
    - Searching SSH configuration                             [ FOUND ]
    - OpenSSH option: AllowTcpForwarding                      [ NOT FOUND ]
    - OpenSSH option: ClientAliveCountMax                     [ NOT FOUND ]
    - OpenSSH option: ClientAliveInterval                     [ NOT FOUND ]
    - OpenSSH option: FingerprintHash                         [ NOT FOUND ]
    - OpenSSH option: GatewayPorts                            [ NOT FOUND ]
    - OpenSSH option: IgnoreRhosts                            [ NOT FOUND ]
    - OpenSSH option: LoginGraceTime                          [ NOT FOUND ]
    - OpenSSH option: LogLevel                                [ NOT FOUND ]
    - OpenSSH option: MaxAuthTries                            [ NOT FOUND ]
    - OpenSSH option: MaxSessions                             [ NOT FOUND ]
    - OpenSSH option: PermitRootLogin                         [ NOT FOUND ]
    - OpenSSH option: PermitUserEnvironment                   [ NOT FOUND ]
    - OpenSSH option: PermitTunnel                            [ NOT FOUND ]
    - OpenSSH option: Port                                    [ NOT FOUND ]
    - OpenSSH option: PrintLastLog                            [ NOT FOUND ]
    - OpenSSH option: StrictModes                             [ NOT FOUND ]
    - OpenSSH option: TCPKeepAlive                            [ NOT FOUND ]
    - OpenSSH option: UseDNS                                  [ NOT FOUND ]
    - OpenSSH option: X11Forwarding                           [ NOT FOUND ]
    - OpenSSH option: AllowAgentForwarding                    [ NOT FOUND ]
    - OpenSSH option: AllowUsers                              [ NOT FOUND ]
    - OpenSSH option: AllowGroups                             [ NOT FOUND ]

[+] SNMP Support
------------------------------------
  - Checking running SNMP daemon                              [ NOT FOUND ]

[+] Databases
------------------------------------
    No database engines found

[+] LDAP Services
------------------------------------
  - Checking OpenLDAP instance                                [ NOT FOUND ]

[+] PHP
------------------------------------
  - Checking PHP                                              [ NOT FOUND ]

[+] Squid Support
------------------------------------
  - Checking running Squid daemon                             [ NOT FOUND ]

[+] Logging and files
------------------------------------
  - Checking for a running log daemon                         [ OK ]
    - Checking Syslog-NG status                               [ NOT FOUND ]
    - Checking systemd journal status                         [ FOUND ]
    - Checking Metalog status                                 [ NOT FOUND ]
    - Checking RSyslog status                                 [ FOUND ]
    - Checking RFC 3195 daemon status                         [ NOT FOUND ]
    - Checking minilogd instances                             [ NOT FOUND ]
    - Checking wazuh-agent daemon status                      [ NOT FOUND ]
  - Checking logrotate presence                               [ OK ]
  - Checking remote logging                                   [ NOT ENABLED ]
  - Checking log directories (static list)                    [ DONE ]
  - Checking open log files                                   [ DONE ]
  - Checking deleted files in use                             [ FILES FOUND ]

[+] Insecure services
------------------------------------
  - Installed inetd package                                   [ NOT FOUND ]
  - Installed xinetd package                                  [ OK ]
    - xinetd status                                           [ NOT ACTIVE ]
  - Installed rsh client package                              [ OK ]
  - Installed rsh server package                              [ OK ]
  - Installed telnet client package                           [ OK ]
  - Installed telnet server package                           [ NOT FOUND ]
  - Checking NIS client installation                          [ OK ]
  - Checking NIS server installation                          [ OK ]
  - Checking TFTP client installation                         [ OK ]
  - Checking TFTP server installation                         [ OK ]

[+] Banners and identification
------------------------------------
  - /etc/issue                                                [ FOUND ]
    - /etc/issue contents                                     [ WEAK ]
  - /etc/issue.net                                            [ FOUND ]
    - /etc/issue.net contents                                 [ WEAK ]

[+] Scheduled tasks
------------------------------------
  - Checking crontab and cronjob files                        [ DONE ]

[+] Accounting
------------------------------------
  - Checking accounting information                           [ NOT FOUND ]
  - Checking sysstat accounting data                          [ DISABLED ]
  - Checking auditd                                           [ NOT FOUND ]

[+] Time and Synchronization
------------------------------------
  - NTP daemon found: systemd (timesyncd)                     [ FOUND ]
  - Checking for a running NTP daemon or client               [ OK ]
  - Last time synchronization                                 [ 932s ]

[+] Cryptography
------------------------------------
  - Checking for expired SSL certificates [0/152]             [ NONE ]

  [WARNING]: Test CRYP-7902 had a long execution: 41.780006 seconds

  - Kernel entropy is sufficient                              [ YES ]
  - HW RNG & rngd                                             [ NO ]
  - SW prng                                                   [ NO ]
  MOR-bit set                                                 [ YES ]

[+] Virtualization
------------------------------------

[+] Containers
------------------------------------
    - Docker
      - Docker daemon                                         [ RUNNING ]
        - Docker info output (warnings)                       [ NONE ]
      - Containers
        - Total containers                                    [ 8 ]
          - Running containers                                [ 6 ]
        - Unused containers                                   [ 2 ]
    - File permissions                                        [ OK ]

[+] Security frameworks
------------------------------------
  - Checking presence AppArmor                                [ FOUND ]
    - Checking AppArmor status                                [ UNKNOWN ]
  - Checking presence SELinux                                 [ NOT FOUND ]
  - Checking presence TOMOYO Linux                            [ NOT FOUND ]
  - Checking presence grsecurity                              [ NOT FOUND ]
  - Checking for implemented MAC framework                    [ NONE ]

[+] Software: file integrity
------------------------------------
  - Checking file integrity tools
Cannot initialize device-mapper, running as non-root user.
Cannot initialize device-mapper, running as non-root user.
Cannot initialize device-mapper, running as non-root user.
Cannot initialize device-mapper, running as non-root user.
  - dm-integrity (status)                                     [ DISABLED ]
Cannot initialize device-mapper, running as non-root user.
Cannot initialize device-mapper, running as non-root user.
Cannot initialize device-mapper, running as non-root user.
Cannot initialize device-mapper, running as non-root user.
  - dm-verity (status)                                        [ DISABLED ]
  - Checking presence integrity tool                          [ NOT FOUND ]

[+] Software: System tooling
------------------------------------
  - Checking automation tooling
  - Automation tooling                                        [ NOT FOUND ]
  - Checking for IDS/IPS tooling                              [ NONE ]

[+] Software: Malware
------------------------------------
  - Malware software components                               [ NOT FOUND ]

[+] File Permissions
------------------------------------
  - Starting file permissions check
    File: /boot/grub/grub.cfg                                 [ OK ]
    File: /etc/crontab                                        [ SUGGESTION ]
    File: /etc/group                                          [ OK ]
    File: /etc/group-                                         [ OK ]
    File: /etc/hosts.allow                                    [ OK ]
    File: /etc/hosts.deny                                     [ OK ]
    File: /etc/issue                                          [ OK ]
    File: /etc/issue.net                                      [ OK ]
    File: /etc/motd                                           [ OK ]
    File: /etc/passwd                                         [ OK ]
    File: /etc/passwd-                                        [ OK ]
    File: /etc/ssh/sshd_config                                [ SUGGESTION ]
    Directory: /etc/cron.d                                    [ SUGGESTION ]
    Directory: /etc/cron.daily                                [ SUGGESTION ]
    Directory: /etc/cron.hourly                               [ SUGGESTION ]
    Directory: /etc/cron.weekly                               [ SUGGESTION ]
    Directory: /etc/cron.monthly                              [ SUGGESTION ]

[+] Home directories
------------------------------------
  - Permissions of home directories                           [ OK ]
  - Ownership of home directories                             [ OK ]
  - Checking shell history files                              [ OK ]

[+] Kernel Hardening
------------------------------------
  - Comparing sysctl key pairs with scan profile
    - dev.tty.ldisc_autoload (exp: 0)                         [ DIFFERENT ]
    - fs.protected_fifos (exp: 2)                             [ DIFFERENT ]
    - fs.protected_hardlinks (exp: 1)                         [ OK ]
    - fs.protected_regular (exp: 2)                           [ OK ]
    - fs.protected_symlinks (exp: 1)                          [ OK ]
    - fs.suid_dumpable (exp: 0)                               [ DIFFERENT ]
    - kernel.core_uses_pid (exp: 1)                           [ DIFFERENT ]
    - kernel.ctrl-alt-del (exp: 0)                            [ OK ]
    - kernel.dmesg_restrict (exp: 1)                          [ DIFFERENT ]
    - kernel.kptr_restrict (exp: 2)                           [ DIFFERENT ]
    - kernel.modules_disabled (exp: 1)                        [ DIFFERENT ]
    - kernel.perf_event_paranoid (exp: 2 3 4)                 [ OK ]
    - kernel.randomize_va_space (exp: 2)                      [ OK ]
    - kernel.sysrq (exp: 0)                                   [ DIFFERENT ]
    - kernel.unprivileged_bpf_disabled (exp: 1)               [ DIFFERENT ]
    - kernel.yama.ptrace_scope (exp: 1 2 3)                   [ OK ]
    - net.ipv4.conf.all.accept_redirects (exp: 0)             [ OK ]
    - net.ipv4.conf.all.accept_source_route (exp: 0)          [ OK ]
    - net.ipv4.conf.all.bootp_relay (exp: 0)                  [ OK ]
    - net.ipv4.conf.all.forwarding (exp: 0)                   [ DIFFERENT ]
    - net.ipv4.conf.all.log_martians (exp: 1)                 [ DIFFERENT ]
    - net.ipv4.conf.all.mc_forwarding (exp: 0)                [ OK ]
    - net.ipv4.conf.all.proxy_arp (exp: 0)                    [ OK ]
    - net.ipv4.conf.all.rp_filter (exp: 1)                    [ DIFFERENT ]
    - net.ipv4.conf.all.send_redirects (exp: 0)               [ DIFFERENT ]
    - net.ipv4.conf.default.accept_redirects (exp: 0)         [ OK ]
    - net.ipv4.conf.default.accept_source_route (exp: 0)      [ DIFFERENT ]
    - net.ipv4.conf.default.log_martians (exp: 1)             [ DIFFERENT ]
    - net.ipv4.icmp_echo_ignore_broadcasts (exp: 1)           [ OK ]
    - net.ipv4.icmp_ignore_bogus_error_responses (exp: 1)     [ OK ]
    - net.ipv4.tcp_syncookies (exp: 1)                        [ OK ]
    - net.ipv4.tcp_timestamps (exp: 0 1)                      [ OK ]
    - net.ipv6.conf.all.accept_redirects (exp: 0)             [ OK ]
    - net.ipv6.conf.all.accept_source_route (exp: 0)          [ OK ]
    - net.ipv6.conf.default.accept_redirects (exp: 0)         [ OK ]
    - net.ipv6.conf.default.accept_source_route (exp: 0)      [ OK ]

[+] Hardening
------------------------------------
    - Installed compiler(s)                                   [ FOUND ]
    - Installed malware scanner                               [ NOT FOUND ]
    - Non-native binary formats                               [ FOUND ]

[+] Custom tests
------------------------------------
  - Running custom tests...                                   [ NONE ]

[+] Plugins (phase 2)
------------------------------------

================================================================================

  -[ Lynis 3.1.6 Results ]-

  Warnings (3):
  ----------------------------
  ! Nameserver 8.8.8.8 does not respond [NETW-2704] 
      https://cisofy.com/lynis/controls/NETW-2704/

  ! Nameserver 1.1.1.1 does not respond [NETW-2704] 
      https://cisofy.com/lynis/controls/NETW-2704/

  ! Couldn't find 2 responsive nameservers [NETW-2705] 
      https://cisofy.com/lynis/controls/NETW-2705/

  Suggestions (43):
  ----------------------------
  * Set a password on GRUB boot loader to prevent altering boot configuration (e.g. boot in single user mode without password) [BOOT-5122] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/BOOT-5122/

  * Consider hardening system services [BOOT-5264] 
    - Details  : Run '/usr/bin/systemd-analyze security SERVICE' for each service
    - Related resources
      * Article: Systemd features to secure service files: https://linux-audit.com/systemd/systemd-features-to-secure-units-and-services/
      * Website: https://cisofy.com/lynis/controls/BOOT-5264/

  * If not required, consider explicit disabling of core dump in /etc/security/limits.conf file [KRNL-5820] 
    - Related resources
      * Article: Understand and configure core dumps on Linux: https://linux-audit.com/software/understand-and-configure-core-dumps-work-on-linux/
      * Website: https://cisofy.com/lynis/controls/KRNL-5820/

  * Check the output of ps for dead or zombie processes [PROC-3612] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PROC-3612/

  * Run pwck manually and correct any errors in the password file [AUTH-9228] 
    - Related resources
      * Article: File integrity of password files: https://linux-audit.com/authentication/file-integrity-of-password-files/
      * Website: https://cisofy.com/lynis/controls/AUTH-9228/

  * Configure password hashing rounds in /etc/login.defs [AUTH-9230] 
    - Related resources
      * Article: Linux password security: hashing rounds: https://linux-audit.com/authentication/configure-the-minimum-password-length-on-linux-systems/
      * Website: https://cisofy.com/lynis/controls/AUTH-9230/

  * Install a PAM module for password strength testing like pam_cracklib or pam_passwdqc or libpam-passwdqc [AUTH-9262] 
    - Related resources
      * Article: Configure minimum password length for Linux systems: https://linux-audit.com/configure-the-minimum-password-length-on-linux-systems/
      * Website: https://cisofy.com/lynis/controls/AUTH-9262/

  * Configure minimum password age in /etc/login.defs [AUTH-9286] 
    - Related resources
      * Article: Configure minimum password length for Linux systems: https://linux-audit.com/configure-the-minimum-password-length-on-linux-systems/
      * Website: https://cisofy.com/lynis/controls/AUTH-9286/

  * Configure maximum password age in /etc/login.defs [AUTH-9286] 
    - Related resources
      * Article: Configure minimum password length for Linux systems: https://linux-audit.com/configure-the-minimum-password-length-on-linux-systems/
      * Website: https://cisofy.com/lynis/controls/AUTH-9286/

  * Default umask in /etc/login.defs could be more strict like 027 [AUTH-9328] 
    - Related resources
      * Article: Set default file permissions on Linux with umask: https://linux-audit.com/filesystems/file-permissions/set-default-file-permissions-with-umask/
      * Website: https://cisofy.com/lynis/controls/AUTH-9328/

  * To decrease the impact of a full /home file system, place /home on a separate partition [FILE-6310] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/FILE-6310/

  * To decrease the impact of a full /tmp file system, place /tmp on a separate partition [FILE-6310] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/FILE-6310/

  * To decrease the impact of a full /var file system, place /var on a separate partition [FILE-6310] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/FILE-6310/

  * Disable drivers like USB storage when not used, to prevent unauthorized storage or data theft [USB-1000] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/USB-1000/

  * Check DNS configuration for the dns domain name [NAME-4028] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NAME-4028/

  * Purge old/removed packages (33 found) with aptitude purge or dpkg --purge command. This will cleanup old configuration files, cron jobs and startup scripts. [PKGS-7346] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PKGS-7346/

  * Install debsums utility for the verification of packages with known good database. [PKGS-7370] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PKGS-7370/

  * Install package apt-show-versions for patch management purposes [PKGS-7394] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PKGS-7394/

  * Install a package audit tool to determine vulnerable packages [PKGS-7398] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PKGS-7398/

  * Remove any unneeded kernel packages [PKGS-7410] 
    - Details  : 12 kernels
    - Solution : validate dpkg -l output and perform cleanup with apt autoremove
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PKGS-7410/

  * Consider using a tool to automatically apply upgrades [PKGS-7420] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PKGS-7420/

  * Check connection to this nameserver and make sure no outbound DNS queries are blocked (port 53 UDP and TCP). [NETW-2704] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NETW-2704/

  * Check connection to this nameserver and make sure no outbound DNS queries are blocked (port 53 UDP and TCP). [NETW-2704] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NETW-2704/

  * Check your resolv.conf file and fill in a backup nameserver if possible [NETW-2705] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NETW-2705/

  * Determine if protocol 'dccp' is really needed on this system [NETW-3200] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NETW-3200/

  * Determine if protocol 'sctp' is really needed on this system [NETW-3200] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NETW-3200/

  * Determine if protocol 'rds' is really needed on this system [NETW-3200] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NETW-3200/

  * Determine if protocol 'tipc' is really needed on this system [NETW-3200] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/NETW-3200/

  * Access to CUPS configuration could be more strict. [PRNT-2307] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/PRNT-2307/

  * Enable logging to an external logging host for archiving purposes and additional protection [LOGG-2154] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/LOGG-2154/

  * Check what deleted files are still in use and why. [LOGG-2190] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/LOGG-2190/

  * Add a legal banner to /etc/issue, to warn unauthorized users [BANN-7126] 
    - Related resources
      * Article: The real purpose of login banners: https://linux-audit.com/the-real-purpose-of-login-banners-on-linux/
      * Website: https://cisofy.com/lynis/controls/BANN-7126/

  * Add legal banner to /etc/issue.net, to warn unauthorized users [BANN-7130] 
    - Related resources
      * Article: The real purpose of login banners: https://linux-audit.com/the-real-purpose-of-login-banners-on-linux/
      * Website: https://cisofy.com/lynis/controls/BANN-7130/

  * Enable process accounting [ACCT-9622] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/ACCT-9622/

  * Enable sysstat to collect accounting (disabled) [ACCT-9626] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/ACCT-9626/

  * Enable auditd to collect audit information [ACCT-9628] 
    - Related resources
      * Article: Linux audit framework 101: basic rules for configuration: https://linux-audit.com/linux-audit-framework/linux-audit-framework-101-basic-rules-for-configuration/
      * Article: Monitoring Linux file access, changes and data modifications: https://linux-audit.com/monitoring-linux-file-access-changes-and-modifications/
      * Website: https://cisofy.com/lynis/controls/ACCT-9628/

  * Check output of aa-status [MACF-6208] 
    - Details  : /sys/kernel/security/apparmor/profiles
    - Solution : Run aa-status
    - Related resources
      * Article: AppArmor: https://linux-audit.com/security-frameworks/apparmor/
      * Website: https://cisofy.com/lynis/controls/MACF-6208/

  * Install a file integrity tool to monitor changes to critical and sensitive files [FINT-4350] 
    - Related resources
      * Article: Monitoring Linux file access, changes and data modifications: https://linux-audit.com/monitoring-linux-file-access-changes-and-modifications/
      * Article: Monitor for file changes on Linux: https://linux-audit.com/monitor-for-file-system-changes-on-linux/
      * Website: https://cisofy.com/lynis/controls/FINT-4350/

  * Determine if automation tools are present for system management [TOOL-5002] 
    - Related resources
      * Website: https://cisofy.com/lynis/controls/TOOL-5002/

  * Consider restricting file permissions [FILE-7524] 
    - Details  : See screen output or log file
    - Solution : Use chmod to change file permissions
    - Related resources
      * Website: https://cisofy.com/lynis/controls/FILE-7524/

  * One or more sysctl values differ from the scan profile and could be tweaked [KRNL-6000] 
    - Solution : Change sysctl value or disable test (skip-test=KRNL-6000:<sysctl-key>)
    - Related resources
      * Article: Linux hardening with sysctl settings: https://linux-audit.com/linux-hardening-with-sysctl/
      * Article: Overview of sysctl options and values: https://linux-audit.com/kernel/sysctl/
      * Website: https://cisofy.com/lynis/controls/KRNL-6000/

  * Harden compilers like restricting access to root user only [HRDN-7222] 
    - Related resources
      * Article: Why remove compilers from your system?: https://linux-audit.com/software/why-remove-compilers-from-your-system/
      * Website: https://cisofy.com/lynis/controls/HRDN-7222/

  * Harden the system by installing at least one malware scanner, to perform periodic file system scans [HRDN-7230] 
    - Solution : Install a tool like rkhunter, chkrootkit, OSSEC, Wazuh
    - Related resources
      * Article: Antivirus for Linux: is it really needed?: https://linux-audit.com/malware/antivirus-for-linux-really-needed/
      * Article: Monitoring Linux Systems for Rootkits: https://linux-audit.com/monitoring-linux-systems-for-rootkits/
      * Website: https://cisofy.com/lynis/controls/HRDN-7230/

  Follow-up:
  ----------------------------
  - Show details of a test (lynis show details TEST-ID)
  - Check the logfile for all details (less /home/llamathehutt/lynis.log)
  - Read security controls texts (https://cisofy.com)
  - Use --upload to upload data to central system (Lynis Enterprise users)

================================================================================

  Lynis security scan details:

  Scan mode:
  Normal [ ]  Forensics [ ]  Integration [ ]  Pentest [▆] (running non-privileged)

  Lynis modules:
  - Compliance status      [?]
  - Security audit         [V]
  - Vulnerability scan     [V]

  Details:
  Hardening index : 62 [############        ]
  Tests performed : 248
  Plugins enabled : 0

  Software components:
  - Firewall               [V]
  - Intrusion software     [X]
  - Malware scanner        [X]

  Files:
  - Test and debug information      : /home/llamathehutt/lynis.log
  - Report data                     : /home/llamathehutt/lynis-report.dat

================================================================================

  Skipped tests due to non-privileged mode:

    BOOT-5108 - Check Syslinux as bootloader
    BOOT-5109 - Check rEFInd as bootloader
    BOOT-5116 - Check if system is booted in UEFI mode
    BOOT-5140 - Check for ELILO boot loader presence
    AUTH-9216 - Check group and shadow group files
    AUTH-9229 - Check password hashing methods
    AUTH-9252 - Check ownership and permissions for sudo configuration files
    AUTH-9288 - Checking for expired passwords
    FILE-6368 - Checking ACL support on root file system
    PKGS-7390 - Check Ubuntu database consistency
    PKGS-7392 - Check for Debian/Ubuntu security updates
    FIRE-4508 - Check used policies of iptables chains
    FIRE-4512 - Check iptables for empty ruleset
    FIRE-4513 - Check iptables for unused rules
    FIRE-4540 - Check for empty nftables configuration
    FIRE-4586 - Check firewall logging
    CRYP-7930 - Determine if system uses LUKS block device encryption
    CRYP-7931 - Determine if system uses encrypted swap

================================================================================

  Lynis 3.1.6

  Auditing, system hardening, and compliance for UNIX-based systems
  (Linux, macOS, BSD, and others)

  2007-2025, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)

================================================================================

  [TIP]: Enhance Lynis audits by adding your settings to custom.prf (see /etc/lynis/default.prf for all settings)
