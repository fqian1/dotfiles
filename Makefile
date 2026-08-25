HOME_SRC   := $(shell find home -type f)
SYSTEM_SRC := $(shell find system -type f)

HOME_EXCEPTIONS   := home/%.age
SYSTEM_EXCEPTIONS := system/etc/doas.conf

HOME_OBJS_GENERIC   := $(patsubst home/%,$(HOME)/%,$(filter-out $(HOME_EXCEPTIONS),$(HOME_SRC)))
SYSTEM_OBJS_GENERIC := $(patsubst system/%,/%,$(filter-out $(SYSTEM_EXCEPTIONS),$(SYSTEM_SRC)))

HOME_OBJS   := $(HOME_OBJS_GENERIC) $(HOME)/.ssh/id_github
SYSTEM_OBJS := $(SYSTEM_OBJS_GENERIC)

.PHONY: all home system require-root
all: home system

home: $(HOME_OBJS)
	@mv $(HOME)/.bash_profile $(HOME)/.bash_profile.bak
	@echo "==> Home dotfiles installed"

system: require-root $(SYSTEM_OBJS)
	@echo "==> System files installed"

require-root:
	@[ $$(id -u) -eq 0 ] || { echo "Must be root to install system files."; exit 1; }

$(HOME_OBJS_GENERIC): $(HOME)/% : $(CURDIR)/home/%
	@mkdir -p $(@D)
	@[ ! -e $@ ] || mv $@ $@.bak
	ln -sf $< $@

$(SYSTEM_OBJS_GENERIC): /% : $(CURDIR)/system/%
	@mkdir -p $(@D)
	@[ ! -e $@ ] || mv $@ $@.bak
	cp $< $@
	chmod 0644 $@
	chown root:wheel $@

$(HOME)/.ssh/id_github: $(CURDIR)/home/.ssh/id_github.age
	@mkdir -p $(@D)
	@read -p "Enter passphrase: " pass; AGE_PASSPHRASE="$$pass" age -d $< > $@
	chmod 600 $@

/etc/doas.conf: $(CURDIR)/system/etc/doas.conf
	@mkdir -p $(@D)
	@[ ! -e $@ ] || mv $@ $@.bak
	cp $< $@
	chmod 0400 $@
	chown root:wheel $@

/etc/sv/kmscon/run: $(CURDIR)/system/etc/sv/kmscon/run
	@mkdir -p $(@D)
	unlink /var/service/agetty-tty1
	cp $< $@
	chmod 0755 $@
	chown root:wheel $@
	ln -sf $(@D) /var/service
