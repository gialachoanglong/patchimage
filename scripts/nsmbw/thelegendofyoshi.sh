#!/bin/bash

WORKDIR=nsmb.d
DOL=${WORKDIR}/sys/main.dol
DOWNLOAD_LINK="https://www.dropbox.com/s/t2u8soleg8qeix8/The%20Legend%20Of%20Yoshi.zip"
RIIVOLUTION_ZIP="The Legend Of Yoshi.zip"
RIIVOLUTION_DIR="TLOY (Riivolution) [P] [J] [E] (08-31-2016)  [no custom logo]/The Legend Of Yoshi/tloy"
GAMENAME="The Legend of Yoshi"
XML_SOURCE="${RIIVOLUTION_DIR}"
XML_FILE="${RIIVOLUTION_DIR}/../riivolution/TLOY ("
GAME_TYPE=RIIVOLUTION
BANNER_LOCATION=${WORKDIR}/files/opening.bnr
WBFS_MASK="SMN[PEJ]01"

show_notes () {

echo -e \
"************************************************
${GAMENAME}

Source:			http://rvlution.net/thread/4349-the-legend-of-yoshi-05-28-16-dlc/
Base Image:		New Super Mario Bros. Wii (SMN?01)
Supported Versions:	EURv1, EURv2, USAv1, USAv2, JPNv1
************************************************"

}

detect_game_version () {

	nsmbw_version
	GAMEID=SMN${REG_LETTER}66
	XML_FILE="${XML_FILE}${REG_LETTER}).xml"

}

place_files () {

	case ${VERSION} in
		EUR* )
			cp "${RIIVOLUTION_DIR}"/OpeningP/* "${WORKDIR}"/files/EU/Layout/openingTitle/
		;;

		USAv* )
			cp "${RIIVOLUTION_DIR}"/OpeningE/* "${WORKDIR}"/files/US/Layout/openingTitle/
		;;

		JPNv1 )
			cp "${RIIVOLUTION_DIR}"/OpeningJ/* "${WORKDIR}"/files/JP/Layout/openingTitle/
		;;
	esac

	cp "${RIIVOLUTION_DIR}"/Stage/Texture/* "${WORKDIR}"/files/Stage/Texture/
	cp "${RIIVOLUTION_DIR}"/Stage/*.arc "${WORKDIR}"/files/Stage/
	cp -r "${RIIVOLUTION_DIR}"/Layout/ "${WORKDIR}"/files/
	cp -r "${RIIVOLUTION_DIR}"/Object/ "${WORKDIR}"/files/
	cp "${RIIVOLUTION_DIR}"/Sound/Stream/* "${WORKDIR}"/files/Sound/stream/
	cp "${RIIVOLUTION_DIR}"/Sound/*.brsar "${WORKDIR}"/files/Sound/
	cp "${RIIVOLUTION_DIR}"/WorldMap/* "${WORKDIR}"/files/WorldMap/

}

dolpatch () {

	cp "${XML_FILE}" "${XML_FILE}".new
	sed -e 's/80001800/803482C0/g' -i "${XML_FILE}".new
	XML_FILE="${XML_FILE}".new

	${WIT} dolpatch ${DOL} xml="${PATCHIMAGE_PATCH_DIR}/NSMBW_AP.xml" -q

}
