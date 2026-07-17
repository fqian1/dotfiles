HOME_SRC   != find home -type f
SYSTEM_SRC != find system -type f

HOME_EXCEPTIONS   = home/.login_conf

SYSTEM_EXCEPTIONS = system/usr/local/etc/doas.conf \
                    system/usr/local/etc/rc.d/tmux

# ----- filter out exceptions -----
HOME_SRC_GENERIC   = ${HOME_SRC}
.for ex in ${HOME_EXCEPTIONS}
HOME_SRC_GENERIC   := ${HOME_SRC_GENERIC:N${ex}}
.endfor

SYSTEM_SRC_GENERIC = ${SYSTEM_SRC}
.for ex in ${SYSTEM_EXCEPTIONS}
SYSTEM_SRC_GENERIC := ${SYSTEM_SRC_GENERIC:N${ex}}
.endfor

HOME_OBJS_GENERIC   = ${HOME_SRC_GENERIC:S|^home/|${HOME}/|}
SYSTEM_OBJS_GENERIC = ${SYSTEM_SRC_GENERIC:S|^system/|/|}

# full list of objects – generic + specific overrides
HOME_OBJS   = ${HOME_OBJS_GENERIC} ${HOME}/.login_conf
SYSTEM_OBJS = ${SYSTEM_OBJS_GENERIC} /usr/local/etc/doas.conf /usr/local/etc/rc.d/tmux

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
