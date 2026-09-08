HOME_SRC := $(shell find home -type f ! -name "*.age")
SYSTEM_SRC := $(shell find system -type f ! -name "*.age")
HOME_SECRETS := $(shell find home -type f -name "*.age")
SYSTEM_SECRETS := $(shell find system -type f -name "*.age")

HOME_OBJS := $(patsubst home/%,$(HOME)/%,$(HOME_SRC))
SYSTEM_OBJS := $(patsubst system/%,/%,$(SYSTEM_SRC))
HOME_SECRET_OBJS = $(patsubst home/%,$(HOME)/%,$(HOME_SECRETS:.age=))
SYSTEM_SECRET_OBJS := $(patsubst system/%,/%,$(SYSTEM_SECRETS:.age=))

.PHONY: all home system clean distclean
all: home system

home: $(HOME_OBJS) $(HOME_SECRET_OBJS)
	@[ -e "$$(HOME)"/.bash_profile ] && mv "$(HOME)"/.bash_profile "$(HOME)"/.bash_profile.bak || true
	@echo "==> Home dotfiles installed"

system: $(SYSTEM_OBJS) $(SYSTEM_SECRET_OBJS)
	@echo "==> System dotfiles installed"

$(HOME_OBJS): $(HOME)/% : home/%
	@mkdir -p $(@D)
	@[ ! -e $@ -o -L $@ ] || mv $@ $@.bak
	ln -sf $(abspath $<) $@

$(HOME_SECRET_OBJS): $(HOME)/% : home/%.age
	@mkdir -p $(@D)
	age -d $< > $@
	chmod 600 $@

$(SYSTEM_OBJS): /% : system/%
	@doas mkdir -p $(@D)
	@[ ! -e $@ -o -L $@ ] || mv $@ $@.bak
	doas cp $< $@
	doas chown root:wheel $@
	doas chmod 644 $@

$(SYSTEM_SECRET_OBJS): /% : system/%.age
	@doas mkdir -p $(@D)
	doas true && age -d $< | doas tee $@ >/dev/null
	doas chmod 600 $@
	doas chown root:wheel $@

clean:
	rm -f $(HOME_OBJS) $(HOME_SECRET_OBJS)
	doas rm -f $(SYSTEM_OBJS) $(SYSTEM_SECRET_OBJS)
	for f in $(HOME_OBJS) $(HOME_OBJS_SECRETS); do [ -e "$$f".bak ] && mv "$$f".bak "$$f"; done
	@echo "Symlinks removed, backups restored"

distclean: clean
	for f in $(HOME_OBJS) $(HOME_SECRET_OBJS) $(SYSTEM_OBJS) $(SYSTEM_SECRET_OBJS); do [ -e "$$f".bak ] && doas rm -f "$$f".bak; done
	@echo "Backups cleaned"
