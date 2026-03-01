PROJECT_NAME := homebrew-tap
PROJECT_VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)

.PHONY: help release-highlights validate ci

help:
	@printf "%s %s\n" "$(PROJECT_NAME)" "$(PROJECT_VERSION)"
	@printf "\nCommands:\n"
	@printf "  %-22s %s\n" "help" "Show this help output"
	@printf "  %-22s %s\n" "release-highlights" "Regenerate sk release highlights in README"
	@printf "  %-22s %s\n" "validate" "Run local validation checks"
	@printf "  %-22s %s\n" "ci" "Run CI-equivalent validation checks"

release-highlights:
	./scripts/update-sk-release-highlights.sh

validate:
	./scripts/check-hero-asset.sh
	@before=$$(python -c "import hashlib;print(hashlib.sha256(open('README.md','rb').read()).hexdigest())"); \
	./scripts/update-sk-release-highlights.sh; \
	after=$$(python -c "import hashlib;print(hashlib.sha256(open('README.md','rb').read()).hexdigest())"); \
	if [ "$$before" != "$$after" ]; then \
		echo "README release highlights are stale. Run make release-highlights and commit the result."; \
		exit 1; \
	fi
	npx --yes eslint --version
	npx --yes jest --version
	npx --yes markdownlint-cli2 "README.md" "docs/**/*.md"

ci: validate
