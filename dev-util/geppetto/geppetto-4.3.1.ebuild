# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils

MAGIC="R201501182354"

DESCRIPTION="An integrated toolset for developing puppet modules and manifests"
HOMEPAGE="http://puppetlabs.github.io/geppetto/"
SRC_URI="x86?   ( https://downloads.puppetlabs.com/geppetto/4.x/geppetto-linux.gtk.x86-${PV}-${MAGIC}.zip )
	 amd64? ( https://downloads.puppetlabs.com/geppetto/4.x/geppetto-linux.gtk.x86_64-${PV}-${MAGIC}.zip )"

S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0 EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="virtual/jre"
RESTRICT="mirror"

src_unpack() {
	unpack ${A}
}

src_install() {
	mv "${S}/icon.xpm" "${S}/${PN}.xpm"
	dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r configuration
	doins -r features
	doins -r p2
	doins -r plugins
	doins artifacts.xml
	doins geppetto.ini
	doicon ${PN}.xpm
	exeinto /opt/${PN}
	doexe geppetto
	dosym /opt/${PN}/geppetto /usr/bin/geppetto
	make_desktop_entry /opt/${PN}/${PN} Geppetto /usr/share/pixmaps/${PN}.xpm "IDE;Development"
}
