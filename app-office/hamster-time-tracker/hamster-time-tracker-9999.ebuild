# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="Time tracking for the masses"
HOMEPAGE="http://projecthamster.wordpress.com"
EGIT_REPO_URI="https://github.com/projecthamster/hamster.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/gconf-python
	gnome-base/gconf[introspection]
	dev-python/pyxdg
	>=x11-libs/gtk+-3.10
	sys-devel/gettext
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_unpack() {
	git-r3_src_unpack
}

src_configure() {
	./waf configure build --prefix="${EPREFIX}/usr" || die
}

src_install() {
	./waf install --destdir="${D%/}" || die
	cd "${ED%/}/usr/$(get_libdir)" || die
	cp -pr python2.7 $(eselect python show --python3) || die
}
