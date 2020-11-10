# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3 gnome2-utils

DESCRIPTION="Time tracking for the masses"
HOMEPAGE="http://projecthamster.wordpress.com"
EGIT_REPO_URI="https://github.com/projecthamster/hamster.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/pyxdg
	>=x11-libs/gtk+-3.10
	sys-devel/gettext
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	default

	# avoid writing to live file system during src_install
	sed -i -e 's/gtk-update-icon-cache/true/' data/wscript || die
}

src_configure() {
	./waf configure build --prefix="${EPREFIX}/usr" || die
}

src_install() {
	./waf install --destdir="${D%/}" || die
	rm "${ED%/}/usr/share/glib-2.0/schemas/gschemas.compiled" || die
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
