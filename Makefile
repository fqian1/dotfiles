HOME_SRC != find home -type f
SYSTEM_SRC != find system -type f

HOME_OBJS = ${HOME_SRC:C/^home/${HOME}/}
SYSTEM_OBJS = ${SYSTEM_SRC:C/^system//}

${HOME_OBJS}: ${HOME}/%: home/%
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	ln -sf ${.CURDIR}/$< $@

${SYSTEM_OBJS}: /%: system/%
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp ${.CURDIR}/$< $@
	chmod 0644 $@
	chown root:wheel $@

.PHONY: all home system
all: home system
home: ${HOME_OBJS}
system: ${SYSTEM_OBJS}
