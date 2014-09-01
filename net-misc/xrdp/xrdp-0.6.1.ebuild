# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xrdp/xrdp-0.4.2.ebuild,v 1.2 2011/06/18 01:41:44 jasiu Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="An open source remote desktop protocol(rdp) server."
HOMEPAGE="http://xrdp.sourceforge.net/"
MY_P="${PN}-v${PV}"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}
	 net-misc/tigervnc"

S="${WORKDIR}/${MY_P}"
DESTDIR="/usr/$(get_libdir)/${PN}"

src_prepare() {
	eautoreconf
	cd sesman/tools && ln -vs ../config.c .; cd -
	default
	EXTRA_ECONF="--localstatedir=${EPREFIX}/var"
}

src_install() {
	sed -i 's/\(AllowRootLogin\)=1/\1=0/' sesman/sesman.ini
	default
	newinitd "${FILESDIR}/${PN}-initd" ${PN}
	newconfd "${FILESDIR}/${PN}-confd" ${PN}
}
