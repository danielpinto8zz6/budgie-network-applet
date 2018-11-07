# Budgie Network Applet
This is a fork of [Wingpanel Network Indicator](https://github.com/elementary/wingpanel-indicator-network), ported to budgie desktop


![Screenshot](data/screenshot.png?raw=true)

## Building and Installation

You'll need the following dependencies:

* gobject-introspection
* libnm-dev
* libnma-dev
* budgie-1.0
* meson
* valac

Run `meson` to configure the build environment and then `ninja` to build

    meson build --prefix=/usr
    cd build
    ninja

To install, use `ninja install`

    sudo ninja install
