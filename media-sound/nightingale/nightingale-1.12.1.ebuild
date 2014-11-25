# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils multilib autotools

PV="1.12"
TAG_ID="9b9c8bf"


DESCRIPTION="Nightingale is a community support project for the powerful media player, Songbird"
HOMEPAGE="http://getnightingale.com/"
SRC_URI="http://github.com/nightingale-media-player/nightingale-hacking/archive/${P}.tar.gz -> ${P}.tar.gz
	 amd64? ( mirror://sourceforge/ngale/${PV}-Build-Deps/linux-x86_64-${PV}-20130316-release-final.tar.lzma )
	 x86? ( mirror://sourceforge/ngale/${PV}-Build-Deps/linux-i686-${PV}-20130316-release-final.tar.lzma )
	 mirror://sourceforge/ngale/${PV}-Build-Deps/vendor-${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa oss esd ogg flac faac faad musepack ugly theora speex ffmpeg gnome jpeg +bindist debug test"
RDEPEND="${DEPEND}
	alsa? ( media-plugins/gst-plugins-alsa:0.10 )
	oss?  ( media-plugins/gst-plugins-oss:0.10 )
	ogg? ( media-plugins/gst-plugins-ogg:0.10
		media-plugins/gst-plugins-vorbis:0.10 )
	gnome? ( media-plugins/gst-plugins-gconf:0.10
		 media-plugins/gst-plugins-gnomevfs:0.10 )
	flac? ( media-plugins/gst-plugins-flac:0.10 )
	faac? ( media-plugins/gst-plugins-faac:0.10 )
	faad? ( media-plugins/gst-plugins-faad:0.10 )
	ugly?  ( media-libs/gst-plugins-ugly:0.10 )
	musepack? ( media-plugins/gst-plugins-musepack:0.10 )
	theora? ( media-plugins/gst-plugins-theora:0.10 )
	speex? ( media-plugins/gst-plugins-speex:0.10 )
	ffmpeg? ( media-plugins/gst-plugins-ffmpeg:0.10 )
	jpeg? ( media-plugins/gst-plugins-jpeg:0.10 )"
DEPEND="${RDEPEND}
	x11-libs/libXdmcp
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXext
	x11-libs/libX11
	dev-libs/libIDL
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	media-plugins/gst-plugins-x:0.10
	media-plugins/gst-plugins-xvideo:0.10
	media-plugins/gst-plugins-lame:0.10
	media-plugins/gst-plugins-mpeg2dec:0.10
	media-plugins/gst-plugins-mad:0.10
	>=net-libs/neon-0.26.4
	media-plugins/gst-plugins-neon:0.10
	>=sys-libs/glibc-2.3.2
	>=x11-libs/gtk+-2.0.0
	x11-libs/libXft
	x11-libs/pango
	media-libs/taglib"

S="${WORKDIR}/nightingale-hacking-${P}"

src_prepare() {
	if use amd64; then
		ln -s "${WORKDIR}/linux-x86_64" ./dependencies
	else
		ln -s "${WORKDIR}/linux-i686" ./dependencies
	fi

	ln -s "${WORKDIR}/vendor" ./dependencies

	export GST_PLUGIN_PATH="/usr/$(get_libdir)/gstreamer-0.10"

	eautoconf

	mkdir -p compiled/dist
	#sed -i -e 's/^cd\s\.\.\/$//' allmakefiles.sh || die "sed failed"
	#sed -i -e 's/^cd\scompiled$//' allmakefiles.sh || die "sed failed"
	#sed -i -e '/^SCANNED_MAKEFILE_DIRS="/,/^"/ {/"/! s/^/compiled\//}' allmakefiles.sh || die "sed failed"
}

src_configure() {
	cd compiled && ECONF_SOURCE="${S}" econf \
		$(use_enable debug debug) \
		$(use_enable bindist official) \
		$(use_enable test tests) \
		--with-media-core=gstreamer-system \
		|| die "configure failed"
}

src_compile() {
	emake -C compiled
}

src_install() {
	insinto /opt/${PN}
	doins -r compiled/dist/*
	fperms 755 /opt/${PN}/${PN}
	fperms 755 /opt/${PN}/${PN}-bin
	fperms 755 /opt/${PN}/xulrunner/xulrunner
	fperms 755 /opt/${PN}/xulrunner/xulrunner-bin
	fperms -R a+r /opt/${PN}
        dosym /opt/${PN}/${PN} /opt/bin/${PN}
        
	newicon compiled/dist/chrome/icons/default/default.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Nightingale" ${PN} "AudioVideo;Player"
	domenu ${T}/${PN}-${PN}.desktop || die "Failed to make menu entry"
}
