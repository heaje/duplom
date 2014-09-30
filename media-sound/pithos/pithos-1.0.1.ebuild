# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pithos/pithos-1.0.1.ebuild,v 1.4 2014/04/06 10:45:27 eva Exp $

EAPI=5
PYTHON_COMPAT=(python3_3)
inherit eutils distutils-r1
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
#S="${WORKDIR}/${PN}"

DESCRIPTION="A Pandora Radio (pandora.com) player for the GNOME Desktop"
HOMEPAGE="http://pithos.github.io/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pylast[${PYTHON_USEDEP}]
	media-libs/gstreamer:1.0
	x11-libs/gtk+:3
	dev-python/dbus-python[${PYTHON_USEDEP}]
	media-plugins/gst-plugins-meta:1.0[aac,http,mp3]
	gnome? ( gnome-base/gnome-settings-daemon )
	!gnome? ( dev-libs/keybinder[python] )"

#dev-python/notify-python[${PYTHON_USEDEP}]
#dev-python/pyxdg[${PYTHON_USEDEP}]
#dev-python/pygtk[${PYTHON_USEDEP}]
#	media-libs/gst-plugins-good:1.0
#	media-libs/gst-plugins-bad:1.0
#	dev-python/gst-python:1[${PYTHON_USEDEP}]

src_prepare() {
	distutils-r1_src_prepare
}
