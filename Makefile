SITE_DIR = _site
VANGEN_FILES = \
	$(SITE_DIR)/otk/index.html \
	$(SITE_DIR)/keruu/index.html
VANGEN_VERSION = 1.4.1
GOMARKDOWN_VERSION = latest

build: \
	$(SITE_DIR)/index.html \
	$(SITE_DIR)/style.css \
	$(VANGEN_FILES)

$(SITE_DIR)/style.css: style.css
	cp style.css $(SITE_DIR)/style.css

$(SITE_DIR)/index.html: README.md
	mkdir -p $(SITE_DIR)
	mdtohtml -page -css style.css $< $@

$(VANGEN_FILES): vangen.json
	mkdir -p $(SITE_DIR)
	vangen -config $< -out $(SITE_DIR)

.PHONY: clean
clean:
	rm -rf $(SITE_DIR)

.PHONY: tools
tools:
	go install 4d63.com/vangen@v$(VANGEN_VERSION)
	go install github.com/gomarkdown/mdtohtml@latest
