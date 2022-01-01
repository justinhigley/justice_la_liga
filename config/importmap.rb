# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@themesberg/flowbite", to: "https://ga.jspm.io/npm:@themesberg/flowbite@1.2.0/dist/flowbite.bundle.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
