HOME_SRC       != find home -type f ! -name "*.age"
SYSTEM_SRC     != find system -type f ! -name "*.age"
HOME_SECRETS   != find home -type f -name "*.age"
SYSTEM_SECRETS != find system -type f -name "*.age"

HOME_OBJS = ${HOME_SRC:S|^home/|${HOME}/|}
SYSTEM_OBJS = ${SYSTEM_SRC:S|^system/|/|}
HOME_SECRET_OBJS = ${HOME_SECRETS:S|^home/|${HOME}/|:S|.age||}
SYSTEM_SECRET_OBJS = ${SYSTEM_SECRETS:S|^system/|/|:S|.age||}

.PHONY: all home system _system clean _clean distclean _distclean
all: home system

home: ${HOME_OBJS} ${HOME_SECRET_OBJS}
	@echo "==> Home dotfiles installed"

system: 
	@echo "Requesting privileges to install system files... "
	@doas $(MAKE) _system
	@echo "==> System dotfiles installed"

_system: ${SYSTEM_OBJS} ${SYSTEM_SECRET_OBJS}

require-root:
	@[ $$(id -u) -eq 0 ] || { echo "Must be root to install system files."; exit 1; }

${HOME_OBJS}: ${@:S|${HOME}/|${.CURDIR}/home/|}
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	ln -sf ${.CURDIR}/home/${@:S|${HOME}/||} $@

${HOME_SECRET_OBJS}: ${@:S|${HOME}/|${.CURDIR}/home/|}.age
	@mkdir -p $(@D)
	age -d ${.ALLSRC} | tee $@ >/dev/null
	chmod 600 $@

${SYSTEM_OBJS}: ${.CURDIR}/system$@
	@mkdir -p ${@:H}
	@[ ! -e $@ ] || mv $@ $@.bak
	cp ${.CURDIR}/system$@ $@
	chown root:wheel $@
	chmod 644 $@

$(SYSTEM_SECRET_OBJS): ${.CURDIR}/system$@.age
	@mkdir -p $(@D)
	age -d $< | tee $@ >/dev/null
	chmod 600 $@
	chown root:wheel $@

clean:
	rm -f $(HOME_OBJS) $(HOME_SECRET_OBJS)
	for f in $(HOME_OBJS) $(HOME_SECRET_OBJS); do [ -e "$$f".bak ] && mv "$$f".bak "$$f" || true; done
	@echo "Requesting privileges to restore system backups... "
	@doas $(MAKE) _clean
	@echo "Symlinks removed, backups restored"

_clean:
	rm -f $(SYSTEM_OBJS) $(SYSTEM_SECRET_OBJS)

distclean: clean
	for f in $(HOME_OBJS) $(HOME_SECRET_OBJS); do rm -f "$$f".bak || true; done
	@echo "Requesting privileges to delete system .bak files... "
	@doas $(MAKE) _distclean
	@echo "Backups cleaned"

_distclean:
	for f in $(SYSTEM_OBJS) $(SYSTEM_SECRET_OBJS); do rm -f "$$f".bak; done
