HOME_SRC := $(shell find home -type f ! -name "*.age")
HOME_SRC_SECRETS := $(shell find home -type f -name "*.age")
HOME_OBJS := $(patsubst home/%,$(HOME)/%,$(HOME_SRC))
HOME_OBJS_SECRETS = $(patsubst home/%,$(HOME)/%,$(HOME_SRC_SECRETS:.age=))

.PHONY: all home clean distclean
all: home

home: $(HOME_OBJS) $(HOME_OBJS_SECRETS)
	@[ -e "$$(HOME)"/.bash_profile ] && mv "$(HOME)"/.bash_profile "$(HOME)"/.bash_profile.bak || true
	@echo "==> Home dotfiles installed"

$(HOME_OBJS): $(HOME)/% : home/%
	@mkdir -p $(@D)
	@[ ! -e $@ -o -L $@ ] || mv $@ $@.bak
	ln -sf $(abspath $<) $@

$(HOME_OBJS_SECRETS): $(HOME)/% : home/%.age
	@mkdir -p $(@D)
	age -d $< > $@
	chmod 600 $@

clean:
	rm -f $(HOME_OBJS)
	for f in $(HOME_OBJS) $(HOME_OBJS_SECRETS); do [ -e "$$f".bak ] && mv "$$f".bak "$$f"; done
	@echo "Symlinks removed, backups restored"

distclean: clean
	for f in $(HOME_OBJS) $(HOME_OBJS_SECRETS); do [ -e "$$f".bak ] && rm -f "$$f".bak; done
	@echo "Backups cleaned."
