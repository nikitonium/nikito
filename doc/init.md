Sample init scripts and service configuration for nikitod
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/nikitod.service:    systemd service unit configuration
    contrib/init/nikitod.openrc:     OpenRC compatible SysV style init script
    contrib/init/nikitod.openrcconf: OpenRC conf.d file
    contrib/init/nikitod.conf:       Upstart service configuration file
    contrib/init/nikitod.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "nikitocore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes nikitod will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, nikitod requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, nikitod will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that nikitod and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If nikitod is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running nikitod without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/nikito.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/nikitod`  
Configuration file:  `/etc/nikitocore/nikito.conf`  
Data directory:      `/var/lib/nikitod`  
PID file:            `/var/run/nikitod/nikitod.pid` (OpenRC and Upstart) or `/var/lib/nikitod/nikitod.pid` (systemd)  
Lock file:           `/var/lock/subsys/nikitod` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the nikitocore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
nikitocore user and group.  Access to nikito-cli and other nikitod rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/nikitod`  
Configuration file:  `~/Library/Application Support/NikitoCore/nikito.conf`  
Data directory:      `~/Library/Application Support/NikitoCore`
Lock file:           `~/Library/Application Support/NikitoCore/.lock`

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start nikitod` and to enable for system startup run
`systemctl enable nikitod`

### OpenRC

Rename nikitod.openrc to nikitod and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/nikitod start` and configure it to run on startup with
`rc-update add nikitod`

### Upstart (for Debian/Ubuntu based distributions)

Drop nikitod.conf in /etc/init.  Test by running `service nikitod start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy nikitod.init to /etc/init.d/nikitod. Test by running `service nikitod start`.

Using this script, you can adjust the path and flags to the nikitod program by
setting the NIKITOD and FLAGS environment variables in the file
/etc/sysconfig/nikitod. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.nikito.nikitod.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.nikito.nikitod.plist`.

This Launch Agent will cause nikitod to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run nikitod as the current user.
You will need to modify org.nikito.nikitod.plist if you intend to use it as a
Launch Daemon with a dedicated nikitocore user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
