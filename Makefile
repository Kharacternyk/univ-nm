OUT_DIR ?= out
SOURCES := $(wildcard *.md)
OUTPUTS := $(patsubst %.md,$(OUT_DIR)/%.html,$(SOURCES))
IMAGE_SOURCES := $(wildcard images/*)
IMAGE_OUTPUTS := $(patsubst %,$(OUT_DIR)/%,$(IMAGE_SOURCES))

.PHONY: all

all: $(OUTPUTS) $(IMAGE_OUTPUTS) $(OUT_DIR)/.gitignore

$(OUT_DIR)/%.html: %.md
	pweave -f md2html $< -o $@

$(OUT_DIR)/images/%: images/%
	mkdir -p $(OUT_DIR)/images
	cp $< $@

$(OUT_DIR)/.gitignore:
	echo '*' > $@
