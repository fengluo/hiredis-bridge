TARGET = hiredis_bridge
LIB_NAME = hiredis_bridge

PREFIX ?= /usr/local

all: $(TARGET)

$(TARGET): *.c
	clang -c *.c
	ar -rcs lib$(LIB_NAME).a *.o
	rm *.o

install:
	mkdir -p $(TARGET)/usr/local/lib
	mkdir -p $(TARGET)/usr/local/include/$(TARGET)
	cp *.h $(TARGET)/usr/local/include/$(TARGET)
	cp lib$(LIB_NAME).a $(TARGET)/usr/local/lib/
	mkdir -p $(PREFIX)
	cp -r $(TARGET)/usr/local/* $(PREFIX)/
	rm lib$(LIB_NAME).a
	rm -r $(TARGET)
