## Process this file with automake to produce Makefile.in

if MINGW
HB_LIBS= \
	-lhb -la52 -lmkv -lavresample -lavformat -lavcodec -lavutil \
	-ldvdnav -ldvdread -lfaac -lmp3lame -lmpeg2 -lvorbis -lvorbisenc \
	-logg -lsamplerate -lx264 -lmp4v2 -lswscale -ltheoraenc -ltheoradec -lz \
	-lbz2 -lpthreadGC2 -lbluray -lass -lfontconfig -lfreetype -lxml2 \
	-lgmodule-2.0
else
HB_LIBS= \
	-lhb -la52 -lmkv -lavresample -lavformat -lavcodec -lavutil \
	-ldvdnav -ldvdread -lfaac -lmp3lame -lmpeg2 -lvorbis -lvorbisenc \
	-logg -lsamplerate -lx264 -lmp4v2 -lswscale -ltheoraenc -ltheoradec -lz \
	-lbz2 -lpthread -lbluray -lass -lfontconfig -lfreetype -lxml2
endif

icons =	\
	hb-icon.256.png \
	hb-icon.128.png \
	hb-icon.64.png \
	hb-icon.48.png \
	hb-icon.32.png \
	hb-icon.24.png \
	hb-icon.22.png \
	hb-icon.16.png

icons_dep =	\
	hb-activity.32.png \
	hb-activity.64.png \
	hb-add-queue.32.png \
	hb-add-queue.64.png \
	hb-canceled.16.png \
	hb-complete.16.png \
	hb-status.32.png \
	hb-status-empty.32.png \
	hb-icon.128.png \
	hb-icon.64.png \
	hb-pause.32.png \
	hb-pause.64.png \
	hb-start.32.png \
	hb-start.64.png \
	hb-pref.32.png \
	hb-showqueue.32.png \
	hb-showqueue.64.png \
	hb-remove.24.png \
	hb-remove.48.png \
	hb-queue-job.16.png \
	hb-queue-pass1.16.png \
	hb-queue-pass2.16.png \
	hb-queue-subtitle.16.png \
	hb-source.32.png \
	hb-source.64.png \
	hb-stop.32.png \
	hb-stop.64.png \
	hb-working0.16.png \
	hb-working1.16.png \
	hb-working2.16.png \
	hb-working3.16.png \
	hb-working4.16.png \
	hb-working5.16.png

hb_menu = ghb.desktop

AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(prefix)/$(DATADIRNAME)/locale"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(datadir)"\" \
	$(GHB_CFLAGS)

AM_CFLAGS = -Wall -g

bin_PROGRAMS = ghb 

# Dummy file, not built.  Forces g++ linking
nodist_EXTRA_ghb_SOURCES = dummy.cpp

ghb_SOURCES = \
	callbacks.c \
	callbacks.h \
	queuehandler.c \
	queuehandler.h \
	audiohandler.c \
	audiohandler.h \
	subtitlehandler.c \
	subtitlehandler.h \
	x264handler.c \
	x264handler.h \
	main.c \
	settings.c \
	settings.h \
	resources.c \
	resources.h \
	presets.c \
	presets.h \
	preview.c \
	icons.c \
	icons.h \
	icon_tools.c \
	icon_tools.h \
	values.c \
	values.h \
	appcast.c \
	appcast.h \
	plist.c \
	plist.h \
	hb-backend.c \
	hb-backend.h \
	renderer_button.h \
	renderer_button.c \
	ghbcellrenderertext.c \
	ghbcellrenderertext.h \
	ghbcompositor.c \
	ghbcompositor.h \
	ghb-dvd.c \
	ghb-dvd.h \
	marshalers.c \
	marshalers.h

if MINGW
ghb_LDFLAGS = \
	-mwindows -Wl,--export-dynamic -Wl,--exclude-libs,ALL
else
ghb_LDFLAGS = \
	-Wl,--export-dynamic -Wl,--exclude-libs,ALL
endif

ghb_LDADD = $(HB_LIBS) $(GHB_LIBS)

ghb_DEPENDENCIES = $(HB_DIR)/libhb/libhb.a

resources.o: resource_data.h

resource_data.h: resources.plist
	python $(srcdir)/quotestring.py resources.plist resource_data.h

widget_reverse.deps: makedeps.py
widget.deps: makedeps.py
	python $(srcdir)/makedeps.py

resources.plist: create_resources resources.list $(icons_dep) internal_defaults.xml standard_presets.xml ghb.ui widget.deps widget_reverse.deps
	./create_resources -I$(srcdir) $(srcdir)/resources.list resources.plist

CREATE_RES.c = \
	create_resources.c \
	plist.c \
	values.c 

CREATE_RES.c.o = $(patsubst %.c,%-native.o,$(CREATE_RES.c))

create_resources: $(CREATE_RES.c.o)
	$(CC_FOR_BUILD) -o $@ $^ $(GHB_TOOLS_LIBS)
 
$(CREATE_RES.c.o): %-native.o: %.c
	$(CC_FOR_BUILD) $(GHB_TOOLS_CFLAGS) -c -o $@ $<

ghbcellrenderertext.$(OBJEXT): marshalers.h

$(srcdir)/marshalers.h: marshalers.list
	glib-genmarshal --prefix=ghb_marshal $(srcdir)/marshalers.list --header > $(srcdir)/marshalers.h

$(srcdir)/marshalers.c: marshalers.list
	glib-genmarshal --prefix=ghb_marshal $(srcdir)/marshalers.list --body > $(srcdir)/marshalers.c

gtk_update_icon_cache = gtk-update-icon-cache -f -t $(DESTDIR)/$(datadir)/icons/hicolor

uninstall-local:
	for icon in $(icons); do \
		SIZE=`echo $$icon | cut -d. -f2`; \
		FILE=`echo $$icon | cut -d. -f1,3`; \
		if [ "$$SIZE" = "svg" ]; then \
			SIZE="scalable"; \
			FILE="$$FILE.svg"; \
		else \
			SIZE="$${SIZE}x$${SIZE}"; \
		fi; \
		rm -f $(DESTDIR)/$(datadir)/icons/hicolor/$$SIZE/apps/$$FILE; \
	done
	@-if test -z "$(DESTDIR)"; then \
		echo "Updating Gtk icon cache."; \
		$(gtk_update_icon_cache); \
	else \
		echo "*** Icon cache not updated. After install, run this:"; \
		echo "***   $(gtk_update_icon_cache)"; \
	fi
	rm -f $(DESTDIR)/$(datadir)/applications/$(hb_menu)

install-data-local:
	for icon in $(icons); do \
		SIZE=`echo $$icon | cut -d. -f2`; \
		FILE=`echo $$icon | cut -d. -f1,3`; \
		if [ "$$SIZE" = "svg" ]; then \
			SIZE="scalable"; \
			FILE="$$FILE.svg"; \
		else \
			SIZE="$${SIZE}x$${SIZE}"; \
		fi; \
		mkdir -p $(DESTDIR)/$(datadir)/icons/hicolor/$$SIZE/apps/; \
		$(INSTALL_DATA) $(srcdir)/$$icon $(DESTDIR)/$(datadir)/icons/hicolor/$$SIZE/apps/$$FILE; \
	done
	@-if test -z "$(DESTDIR)"; then \
		echo "Updating Gtk icon cache."; \
		$(gtk_update_icon_cache); \
	else \
		echo "*** Icon cache not updated. After install, run this:"; \
		echo "***   $(gtk_update_icon_cache)"; \
	fi
	mkdir -p $(DESTDIR)/$(datadir)/applications/; \
	$(INSTALL_DATA) $(srcdir)/$(hb_menu) $(DESTDIR)/$(datadir)/applications/$(hb_menu)
