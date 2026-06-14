HOME_SRC != find home -type f
SYSTEM_SRC != find system -type f

HOME_OBJS = ${HOME_SRC:S/^home\//${HOME}\//g}
SYSTEM_OBJS = ${SYSTEM_SRC:S/^system\//\//g}

.PHONY: all home system
all: home system
home: ${HOME_OBJS}
system: ${SYSTEM_OBJS}

${HOME_OBJS}: ${@:S/${HOME}\//${.CURDIR}\/home\//}
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	ln -sf ${.CURDIR}/home/${@:S/${HOME}\///} $@

${SYSTEM_OBJS}: ${@:S/\//system\//}
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp ${.CURDIR}/system$@ $@
	chmod 0644 $@
	chown root:wheel $@
