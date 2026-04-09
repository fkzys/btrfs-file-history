PREFIX  = /usr
DESTDIR =

PKGNAME    = btrfs-file-history
PYPACKAGE  = btrfs_file_history
LIBDIR     = $(DESTDIR)$(PREFIX)/lib/$(PKGNAME)
BINDIR     = $(DESTDIR)$(PREFIX)/bin
SHAREDIR   = $(PREFIX)/share
MANDIR     = $(SHAREDIR)/man
ZSH_COMPDIR  = $(SHAREDIR)/zsh/site-functions
BASH_COMPDIR = $(SHAREDIR)/bash-completion/completions
LICENSEDIR = $(DESTDIR)$(PREFIX)/share/licenses/$(PKGNAME)

MANPAGES = man/btrfs-file-history.8

.PHONY: build install uninstall test man clean

build:
	@echo "Pure Python — nothing to compile"

test:
	python -m pytest tests/ -v

man: $(MANPAGES)

man/%.8: man/%.8.md
	pandoc -s -t man -o $@ $<

clean:
	rm -f $(MANPAGES)

install:
	install -d $(LIBDIR)/$(PYPACKAGE)
	install -d $(BINDIR)
	install -m644 $(PYPACKAGE)/__init__.py  $(LIBDIR)/$(PYPACKAGE)/
	install -m644 $(PYPACKAGE)/__main__.py  $(LIBDIR)/$(PYPACKAGE)/
	install -m644 $(PYPACKAGE)/cli.py       $(LIBDIR)/$(PYPACKAGE)/
	install -m644 $(PYPACKAGE)/btrfs.py     $(LIBDIR)/$(PYPACKAGE)/
	install -m644 $(PYPACKAGE)/tree.py      $(LIBDIR)/$(PYPACKAGE)/
	install -m644 $(PYPACKAGE)/scanner.py   $(LIBDIR)/$(PYPACKAGE)/
	install -m644 $(PYPACKAGE)/differ.py    $(LIBDIR)/$(PYPACKAGE)/
	install -m644 $(PYPACKAGE)/renderer.py  $(LIBDIR)/$(PYPACKAGE)/
	install -m755 bin/$(PKGNAME)            $(BINDIR)/$(PKGNAME)
	install -Dm644 completions/_btrfs-file-history \
		$(DESTDIR)$(ZSH_COMPDIR)/_btrfs-file-history
	install -Dm644 completions/btrfs-file-history.bash \
		$(DESTDIR)$(BASH_COMPDIR)/btrfs-file-history
	install -Dm644 man/btrfs-file-history.8 \
		$(DESTDIR)$(MANDIR)/man8/btrfs-file-history.8
	install -Dm644 LICENSE $(LICENSEDIR)/LICENSE

uninstall:
	rm -f  $(BINDIR)/$(PKGNAME)
	rm -rf $(LIBDIR)
	rm -f  $(DESTDIR)$(ZSH_COMPDIR)/_btrfs-file-history
	rm -f  $(DESTDIR)$(BASH_COMPDIR)/btrfs-file-history
	rm -f  $(DESTDIR)$(MANDIR)/man8/btrfs-file-history.8
	rm -rf $(LICENSEDIR)
