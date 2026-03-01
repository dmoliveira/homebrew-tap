PROJECT_NAME := homebrew-tap
PROJECT_VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)

.PHONY: help release-highlights

help:
	@printf "%s %s\n" "$(PROJECT_NAME)" "$(PROJECT_VERSION)"
	@printf "\nCommands:\n"
	@printf "  %-22s %s\n" "help" "Show this help output"
	@printf "  %-22s %s\n" "release-highlights" "Regenerate sk release highlights in README"

release-highlights:
	./scripts/update-sk-release-highlights.sh
