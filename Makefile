SERVICE=systemd
build:
	: run make install

install: install-base install-service-all

install-base:
	mkdir -p $(DESTDIR)/usr/bin
	install disable.sh $(DESTDIR)/usr/bin/disable-secondary-gpu
	make install -C gui

install-service-all: install-systemd install-openrc install-sysvinit install-31

install-service: install-$(SERVICE)

install-systemd:
	mkdir -p $(DESTDIR)/lib/systemd/system/
	install disable.service $(DESTDIR)/lib/systemd/system/disable-secondary-gpu.service


install-openrc:
	mkdir -p $(DESTDIR)/etc/init.d
	install disable.initd $(DESTDIR)/etc/init.d/disable-secondary-gpu

install-sysvinit:
	mkdir -p $(DESTDIR)/etc/init.d
	install disable.sysvinit $(DESTDIR)/etc/init.d/disable-secondary-gpu
	

install-31:
	mkdir -p $(DESTDIR)/etc/31.d
	ln -s ../../usr/bin/disable-secondary-gpu $(DESTDIR)/etc/31.d/disable-secondary-gpu
