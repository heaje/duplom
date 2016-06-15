# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="ruamel.ordereddict"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="a version of dict that keeps keys in insertion resp. sorted order"
HOMEPAGE="https://pypi.python.org/pypi/ruamel.ordereddict"
SRC_URI="mirror://pypi/r/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/ruamel-base[${PYTHON_USEDEP}]"
DEPEND="${RDEPED}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -i -e 's|from ruamel.ordereddict|from _ordereddict|' \
		test/*.py || die

	distutils-r1_python_prepare_all
}

# Run tests with verbose output failing on the first failing test.
python_test() {
	py.test -vvx test || die
}
