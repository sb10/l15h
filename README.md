# l15h

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