# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="The leading eclipse IDE for Ajax and today's web platforms"
HOMEPAGE="http://www.aptana.com"
SRC_URI="https://github.com/aptana/studio3/releases/download/v${PV}/Aptana_Studio_3_Setup_Linux_x86_64_${PV}.zip"
LICENSE="EPL-1.0"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/libjpeg-turbo
	 >=virtual/jre-1.5
	 media-libs/libpng:1.2
	 x11-libs/gtk+:2
	 sys-apps/net-tools
	"

src_install() {
	einfo "Installing Aptana"
	dodir "/opt/${PN}"
	local dest="${D}/opt/${PN}"
	cd ${WORKDIR}/Aptana_Studio_3/
	cp -pPR configuration/ features/ plugins/ "${dest}" || die "Failed to install Files"
	insinto "/opt/${PN}"
	doins icon.xpm about.html AptanaStudio3.ini full_uninstall.txt version.txt
	exeinto "/opt/${PN}"
	doexe AptanaStudio3

	dodir /opt/bin
	echo "#!/bin/sh" > ${T}/AptanaStudio
	echo "/opt/${PN}/AptanaStudio3" >> ${T}/AptanaStudio
	dobin ${T}/AptanaStudio

	make_desktop_entry "AptanaStudio" "Aptana Studio" "/opt/${PN}/icon.xpm" "Development"
}
