HOME_SRC != find home -type f
SYSTEM_SRC != find system -type f

HOME_OBJS = ${HOME_SRC:S|^home/|${HOME}/|}
SYSTEM_OBJS = ${SYSTEM_SRC:S|^system/|/|}

all: home system
home: ${HOME_OBJS}
system: ${SYSTEM_OBJS}
	
${HOME_OBJS}: ${@:S|${HOME}/|${.CURDIR}/home/|}
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	ln -sf ${.CURDIR}/home/${@:S|${HOME}/||} $@

${SYSTEM_OBJS}: ${@:S|/|system/|}
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp ${.CURDIR}/system$@ $@
	chmod 0644 $@
	chown root:wheel $@

${HOME}/.login_conf: home/.login_conf
	cp home/.login_conf $@
	chmod 0644 $@
	chown ${USER}:wheel $@

/usr/local/etc/doas.conf: system/usr/local/etc/doas.conf
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp system$@ $@
	chmod 0400 $@
	chown root:wheel $@

.PHONY: clean restore
clean:
	rm -f ${HOME_OBJS} ${SYSTEM_OBJS}

restore:
	@for f in ${HOME_OBJS} ${SYSTEM_OBJS}; do [ -f "$$f.bak" ] && mv "$$f.bak" "$$f"; done
