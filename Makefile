pandoc_opt := --defaults=pandoc.yaml --metadata-file=metadata.yaml --lua-filter minted.lua

markdown_files := $(wildcard *.md)
pdf_files := $(patsubst %.md,%.pdf,$(markdown_files))
latex_files := $(patsubst %.md,%.tex,$(markdown_files))

.PHONY: all clean

all: $(pdf_files)

$(pdf_files): %.pdf: %.md $(option_file) metadata.yaml pandoc.yaml
	pandoc -t beamer $(pandoc_opt) $< -o $@

$(latex_files): %.tex: %.md $(option_file) metadata.yaml pandoc.yaml
	pandoc -s -t beamer $(pandoc_opt) $< -o $@

clean:
	$(RM) $(pdf_files) $(tex_files)

