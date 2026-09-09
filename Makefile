HOME_SRC := $(shell find home -type f ! -name "*.age")
SYSTEM_SRC := $(shell find system -type f ! -name "*.age")
HOME_SECRETS := $(shell find home -type f -name "*.age")
SYSTEM_SECRETS := $(shell find system -type f -name "*.age")

HOME_OBJS := $(patsubst home/%,$(HOME)/%,$(HOME_SRC))
SYSTEM_OBJS := $(patsubst system/%,/%,$(SYSTEM_SRC))
HOME_SECRET_OBJS := $(patsubst home/%,$(HOME)/%,$(HOME_SECRETS:.age=))
SYSTEM_SECRET_OBJS := $(patsubst system/%,/%,$(SYSTEM_SECRETS:.age=))

.PHONY: all home system _system clean _clean distclean _distclean
all: home system

home: $(HOME_OBJS) $(HOME_SECRET_OBJS)
	@[ -e "$$(HOME)"/.bash_profile ] && mv "$(HOME)"/.bash_profile "$(HOME)"/.bash_profile.bak || true
	@echo "==> Home dotfiles installed"

system: 
	@echo "Requesting privileges to install system files... "
	@doas $(MAKE) _system
	@echo "==> System dotfiles installed"

$(HOME_OBJS): $(HOME)/% : home/%
	@mkdir -p $(@D)
	@[ ! -e $@ -o -L $@ ] || mv $@ $@.bak
	ln -sf $(abspath $<) $@

$(HOME_SECRET_OBJS): $(HOME)/% : home/%.age
	@mkdir -p $(@D)
	age -d $< > $@
	chmod 600 $@

_system: $(SYSTEM_OBJS) $(SYSTEM_SECRET_OBJS)

$(SYSTEM_OBJS): /% : system/%
	@mkdir -p $(@D)
	cp $< $@
	chown root:wheel $@
	chmod 644 $@

$(SYSTEM_SECRET_OBJS): /% : system/%.age
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
