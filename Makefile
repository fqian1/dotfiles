HOME_FILES != find home -type f
SYSTEM_FILES != find system -type f

.PHONY home system

.for file in ${HOME_FILES}
TARGET_PATH = ${HOME}/${file:C/^home\///}
home: ${TARGET_PATH}
${TARGET_PATH}: ${file}
	@mkdir -p ${.TARGET:H}
	ln -sf ${.ALLSRC:tA} ${.TARGET}
.endfor

.for file in ${SYSTEM_FILES}
TARGET_PATH = /${file:C/^system\///}
system: ${TARGET_PATH}
${TARGET_PATH}: ${file}
	@mkdir -p ${.TARGET:H}
	cp ${.ALLSRC} ${.TARGET}
	chown root:wheel ${.TARGET}
	chmod 0644 ${.TARGET}
.endfor
