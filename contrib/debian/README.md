
Debian
====================
This directory contains files used to package nikitod/nikito-qt
for Debian-based Linux systems. If you compile nikitod/nikito-qt yourself, there are some useful files here.

## nikito: URI support ##


nikito-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install nikito-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your nikito-qt binary to `/usr/bin`
and the `../../share/pixmaps/nikito128.png` to `/usr/share/pixmaps`

nikito-qt.protocol (KDE)

