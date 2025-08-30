PAPER=PAPER

# Force reproducible timestamp from latest commit (override any env value)
override SOURCE_DATE_EPOCH := $(shell git log -1 --format=%ct)
export SOURCE_DATE_EPOCH

# Bail out early if not a git repo or no commits
ifeq ($(strip $(SOURCE_DATE_EPOCH)),)
$(error No git commit timestamp found. Init repo and commit at least once, or set SOURCE_DATE_EPOCH.)
endif

# Compute DATE (once) from SOURCE_DATE_EPOCH
ifeq ($(shell uname),Darwin)
DATE := $(shell date -u -r $(SOURCE_DATE_EPOCH) +%Y-%m-%d)
else
DATE := $(shell date -u -d @$(SOURCE_DATE_EPOCH) +%Y-%m-%d)
endif

PANDOC_FLAGS := --metadata date="$(DATE)"

# Quick visibility into what make is actually using
debug:
	@echo "SOURCE_DATE_EPOCH=$(SOURCE_DATE_EPOCH)"
	@echo "DATE=$(DATE)"

pdf:
	quarto render $(PAPER).ipynb \
	--to pdf \
	--pdf-engine=tectonic \
	--execute \
	--no-execute-daemon \
	--no-cache \
	--metadata date="$(DATE)"

clean:
	quarto clean
	rm -f $(PAPER).pdf