build:
	: run make install
install: install-service
	mkdir -p $(DESTDIR)/usr/bin
	install disable.sh $(DESTDIR)/usr/bin/disable-secondary-gpu

ifdef OPENRC
install-service: install-openrc
else
install-service: install-systemd
endif

install-systemd:
	mkdir -p $(DESTDIR)/lib/systemd/system/
	install disable.service $(DESTDIR)/lib/systemd/system/disable-secondary-gpu.service


install-openrc:
	mkdir -p $(DESTDIR)/etc/init.d
	install disable.initd $(DESTDIR)/etc/init.d/disable-secondary-gpu
