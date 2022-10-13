OUT_DIR ?= out
SOURCES := $(wildcard *.md)
OUTPUTS := $(patsubst %.md,$(OUT_DIR)/%.html,$(SOURCES))

.PHONY: all

all: $(OUTPUTS)

$(OUT_DIR)/%.html: %.md
	pweave -f md2html $< -o $@
