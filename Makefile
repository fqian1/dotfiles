HOME_SRC != find home -type f
SYSTEM_SRC != find system -type f

HOME_OBJS = ${HOME_SRC:S/home\//${HOME}\//g}
SYSTEM_OBJS = ${SYSTEM_SRC:S/system\//\//g}

.PHONY: all home system
all: home system
home: ${HOME_OBJS}
system: ${SYSTEM_OBJS}

${HOME_OBJS}:
	@mkdir -p ${.TARGET:H}
	ln -sf ${.CURDIR}/home/${.TARGET:S/${HOME}\///} ${.TARGET}

${SYSTEM_OBJS}:
	@mkdir -p ${.TARGET:H}
	cp system/${.TARGET} ${.TARGET}
	chown root:wheel ${.TARGET}
	chmod 0644 ${.TARGET}
