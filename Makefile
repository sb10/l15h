GOLANGCI_LINT_VERSION := v2.12.2
GO_FILES := $(shell find . -name '*.go' -not -path './vendor/*')

default: test

lint:
	@test -z "$$(gofmt -l $(GO_FILES))"
	@go mod tidy -diff
	@go run github.com/golangci/golangci-lint/v2/cmd/golangci-lint@$(GOLANGCI_LINT_VERSION) run --timeout=5m

test: export CGO_ENABLED = 0
test:
	@go test -tags netgo -timeout 5m --count 1 ./...

race: export CGO_ENABLED = 1
race:
	@go test -tags netgo -race -timeout 5m --count 1 ./...

.PHONY: default lint test race
