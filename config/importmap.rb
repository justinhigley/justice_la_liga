# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@themesberg/flowbite", to: "https://ga.jspm.io/npm:@themesberg/flowbite@1.2.0/dist/flowbite.bundle.js", preload: true
pin "@apollo/client", to: "https://ga.jspm.io/npm:@apollo/client@3.5.6/index.js", preload: true
pin "@wry/context", to: "https://ga.jspm.io/npm:@wry/context@0.6.1/lib/context.esm.js"
pin "@wry/equality", to: "https://ga.jspm.io/npm:@wry/equality@0.5.1/lib/equality.esm.js"
pin "@wry/trie", to: "https://ga.jspm.io/npm:@wry/trie@0.3.1/lib/trie.esm.js"
pin "graphql", to: "https://ga.jspm.io/npm:graphql@16.2.0/index.mjs"
pin "graphql-tag", to: "https://ga.jspm.io/npm:graphql-tag@2.12.6/lib/index.js"
pin "object-assign", to: "https://ga.jspm.io/npm:object-assign@4.1.1/index.js"
pin "optimism", to: "https://ga.jspm.io/npm:optimism@0.16.1/lib/bundle.cjs.js"
pin "react", to: "https://ga.jspm.io/npm:react@17.0.2/index.js"
pin "symbol-observable", to: "https://ga.jspm.io/npm:symbol-observable@4.0.0/lib/index.js"
pin "ts-invariant", to: "https://ga.jspm.io/npm:ts-invariant@0.9.4/lib/invariant.esm.js"
pin "ts-invariant/process/index.js", to: "https://ga.jspm.io/npm:ts-invariant@0.9.4/process/index.js"
pin "tslib", to: "https://ga.jspm.io/npm:tslib@2.3.1/tslib.es6.js"
pin "zen-observable-ts", to: "https://ga.jspm.io/npm:zen-observable-ts@1.2.3/module.js"
pin_all_from "app/javascript/controllers", under: "controllers"
