GHC = ghc
GHC_PKG = $(shell dirname $(shell which $(GHC)))/ghc-pkg

SRC_DIR := src
SRCS := $(shell find $(SRC_DIR) -name *.c)
OBJS := $(patsubst %.c,%.o,$(SRCS))
BIN_DIR := bin

EXE := foreign_lib_repro

HS_RTS_INCLUDE := $(shell $(GHC_PKG) field rts include-dirs --simple-output)
INCLUDES := $(addprefix -I,$(HS_RTS_INCLUDE))

CFLAGS := -Wall -g
CPPFLAGS= $(INCLUDES)
LD_OPTS := -optl-Wl,-rpath,src/

.PHONY: clean run
.DEFAULT_GOAL := build

clean:
	cabal clean
	find . -perm +100 -type f -delete
	rm -f src/Lib_Stub.h
	rm -f $(EXE)
	rm -f $(OBJS)
	rm -rf *.dSYM/

$(SRC_DIR)/libforeign-lib-repro.dylib:
	cabal build
	find dist-newstyle/ -name 'libforeign-lib-repro.dylib' -exec cp {} $(SRC_DIR) \;
	find dist-newstyle/ -name 'Lib_stub.h' -exec cp {} $(SRC_DIR) \;

build: $(SRC_DIR)/libforeign-lib-repro.dylib $(OBJS)
	$(GHC) -no-hs-main $(CFLAGS) $(CPPFLAGS) -o $(EXE) -L$(SRC_DIR) $(LD_OPTS) -lforeign-lib-repro $(OBJS)

run:
	@./$(EXE) $(SRC)
