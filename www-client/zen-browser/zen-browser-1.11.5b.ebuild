# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="Experience tranquillity while browsing the web without people tracking you!"
HOMEPAGE="https://zen-browser.app/"
GITHUB="https://github.com/zen-browser/desktop"
SRC_URI="
	amd64? ( ${GITHUB}/releases/download/${PV}/zen.linux-x86_64.tar.xz -> ${P}-amd64.tar.xz )
	arm64? ( ${GITHUB}/releases/download/${PV}/zen.linux-aarch64.tar.xz -> ${P}-arm64.tar.xz )
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="*"

S=${WORKDIR}

src_install() {
	DEST="${ED}/opt/${PN}"
	mkdir -p "${DEST}" || die "mkdir failed"
	cp -a "zen/"* "${DEST}" || die "cp failed"

	newicon -s 128 "zen/browser/chrome/icons/default/default128.png" "${PN}.png" || die "doicon failed"

	dosym "/opt/zen-browser/zen" "/usr/bin/zen-browser" || die "dosym failed"

	MIMETYPE="MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;"

	make_desktop_entry "${PN} %U" "Zen Browser" ${PN} "Network;WebBrowser" "StartupWMClass=zen-beta\n${MIMETYPE}"
}
