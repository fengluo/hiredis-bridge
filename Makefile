TARGET = hiredis_bridge
LIB_NAME = hiredis_bridge

PREFIX ?= /usr/local

UNAME := $(shell uname)

all: $(TARGET)

$(TARGET): *.c
ifeq ($(UNAME), Linux) # build for linux
	clang -c *.c
	ar -rcs lib$(LIB_NAME).a *.o
endif
ifeq ($(UNAME), Darwin) # build for darwin
	clang -c *.c -I$(PREFIX)/include 
	# libtool -dynamic *.o -o lib$(LIB_NAME).dylib -lSystem -macosx_version_min 10.11
	clang -dynamiclib *.o -I$(PREFIX)/include $(PREFIX)/lib/libhiredis.dylib -o lib$(LIB_NAME).dylib
endif
	rm *.o

install:
	mkdir -p $(TARGET)/usr/local/lib
	mkdir -p $(TARGET)/usr/local/include/$(TARGET)
	cp *.h $(TARGET)/usr/local/include/$(TARGET)
ifeq ($(UNAME), Linux)
	# copy .a
	cp lib$(LIB_NAME).a $(TARGET)/usr/local/lib/
	rm lib$(LIB_NAME).a
endif
ifeq ($(UNAME), Darwin)
	# copy .dylib
	cp lib$(LIB_NAME).dylib $(TARGET)/usr/local/lib/
	rm lib$(LIB_NAME).dylib
endif
	mkdir -p $(PREFIX)
	cp -r $(TARGET)/usr/local/* $(PREFIX)/
	rm -r $(TARGET)
