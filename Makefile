CFLAGS=-g -Wall -Isrc $(OPTFLAGS)
LIBS=-ldl $(OPTLIBS)
PREFIX?=/usr/local

SOURCES=$(wildcard src/*.c,src/**/*.c)
OBJECTS=$(patsubst %.c,%.o,$(SOURCES))

TARGET=build/libautotest.a
SO_TARGET=$(patsubst %.a,%.so,$(TARGET))

all: $(TARGET) $(SO_TARGET) test

$(TARGET): CFLAGS += -fPIC
$(TARGET): build $(OBJECTS)
	ar rcs $@ $(OBJECTS)
	ranlib $@

$(SO_TARGET): $(TARGET) $(OBJECTS)

build:
	@mkdir -p build
	@mkdir -p bin

.PHONY: tests
test: CFLAGS += $(TARGET)
test: $(TESTS)
	tests/runtests $(TESTS)

valgrind:
	VALGRIND="valgrind --log-file=/tmp/valgrind-%p.log" $(MAKE)

clean:
	@rm -rf build bin $(OBJECTS) $(TESTS)
	@rm -f tests/tests.log
	@find . -name "*.gc*" -exec rm {} \;
	@rm -rf `find . -name "*.dSYM" -print`

install: all
	install -d ${DESTDIR}/$(PREFIX)/lib/
	install -d $(TARGET) $(DESTDIR)/$(PREFIX)/lib/
