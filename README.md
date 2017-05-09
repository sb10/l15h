# l15h

[![Go Report Card](https://goreportcard.com/badge/github.com/sb10/l15h)](https://goreportcard.com/report/github.com/sb10/l15h)
[![GoDoc](https://godoc.org/github.com/sb10/l15h?status.svg)](https://godoc.org/github.com/sb10/l15h)
[![Build Status](https://travis-ci.org/sb10/l15h.svg?branch=master)](https://travis-ci.org/sb10/l15h)
[![Coverage Status](https://coveralls.io/repos/github/sb10/l15h/badge.svg?branch=master)](https://coveralls.io/github/sb10/l15h?branch=master)

l15h provides some useful Handlers and logging methods for use with log15:
https://github.com/inconshreveable/log15

## Usage

    import (
        log "github.com/inconshreveable/log15"
        "github.com/sb10/l15h"
    )

    // Store logs in memory for dealing with later
    store := &l15h.Store{}
    h := log.MultiHandler(
        l15h.StoreHandler(store, log.LogfmtFormat()),
        log.StderrHandler,
    )
    log.Root().SetHandler(h)
    log.Debug("debug")
    log.Info("info")
    logs := store.Logs() // logs is a slice of your 2 logs messages as strings

    // Always annotate your logs (other than Info()) with some caller
    // information, with Crit() getting a stack trace
    h = l15h.CallerInfoHandler(log.StderrHandler)
    log.Root().SetHandler(h)
    log.Debug("debug") // includes a caller=
    log.Info("info") // nothing added
    log.Crit("crit") // includes a stack=

    // Combine it all together
    h = l15h.CallerInfoHandler(
        log.MultiHandler(
            l15h.StoreHandler(store, log.LogfmtFormat()),
            log.StderrHandler,
        )
    )
    //...

    // We have Panic and Fatal methods
    l15h.Panic("msg")
    l15h.Fatal("msg")