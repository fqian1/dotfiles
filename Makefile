HOME_SRC   != find home -type f
SYSTEM_SRC != find system -type f

HOME_EXCEPTIONS   = home/.login_conf
SYSTEM_EXCEPTIONS = system/usr/local/etc/doas.conf \
                    system/usr/local/etc/rc.d/tmux

HOME_SRC_GENERIC   = ${HOME_SRC:N${HOME_EXCEPTIONS}}
SYSTEM_SRC_GENERIC = ${SYSTEM_SRC:N${SYSTEM_EXCEPTIONS}}

HOME_OBJS_GENERIC   = ${HOME_SRC_GENERIC:S|^home/|${HOME}/|}
SYSTEM_OBJS_GENERIC = ${SYSTEM_SRC_GENERIC:S|^system/|/|}

# ----- phony targets -----
.PHONY: all home system require-root

all: home system

home: ${HOME_OBJS}
	@echo "==> Home dotfiles installed"

system: require-root ${SYSTEM_OBJS}
	@echo "==> System files installed"

require-root:
	@[ $$(id -u) -eq 0 ] || { echo "Must be root to install system files."; exit 1; }

# ----- generic home rule (symlink) -----
${HOME_OBJS_GENERIC}: ${@:S|${HOME}/|${.CURDIR}/home/|}
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	ln -sf ${.CURDIR}/home/${@:S|${HOME}/||} $@

# ----- generic system rule (copy) -----
${SYSTEM_OBJS_GENERIC}: ${.CURDIR}/system$@
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp ${.CURDIR}/system$@ $@
	chmod 0644 $@
	chown root:wheel $@

# ----- specific overrides -----
${HOME}/.login_conf: ${.CURDIR}/home/.login_conf
	@mkdir -p ${@:H}
	cp ${.CURDIR}/home/.login_conf $@
	chmod 0644 $@
	chown ${USER}:wheel $@

/usr/local/etc/doas.conf: ${.CURDIR}/system/usr/local/etc/doas.conf
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp ${.CURDIR}/system/usr/local/etc/doas.conf $@
	chmod 0400 $@
	chown root:wheel $@

/usr/local/etc/rc.d/tmux: ${.CURDIR}/system/usr/local/etc/rc.d/tmux
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp ${.CURDIR}/system/usr/local/etc/rc.d/tmux $@
	chmod 0755 $@
	chown root:wheel $@
