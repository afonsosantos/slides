# make update                 bun update in every deck
# make update ARGS=--latest   pass extra flags to bun update

.PHONY: update

ifeq ($(OS),Windows_NT)
SHELL := pwsh.exe
.SHELLFLAGS := -NoProfile -Command

update:
	@Get-ChildItem -Filter package.json -Depth 1 | Where-Object { $$_.Directory.FullName -ne $$PWD.Path } | ForEach-Object { Write-Host "==> $$($$_.Directory.Name)"; Push-Location $$_.Directory; bun update $(ARGS); $$code = $$LASTEXITCODE; Pop-Location; if ($$code) { exit $$code } }
else
update:
	@for pkg in */package.json; do \
		dir=$${pkg%/package.json}; \
		echo "==> $$dir"; \
		(cd "$$dir" && bun update $(ARGS)) || exit 1; \
	done
endif
