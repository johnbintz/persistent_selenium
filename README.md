Now you can keep that precious browser window open when doing continuous integration testing.
Save seconds, and sanity, with every test re-run!

Also, the browser stays open at its last state so you can inspect it and more easily
fix your tests and/or code.

Start an instance:

``` bash
persistent_selenium [ --port 9854 ] [ --browser firefox ]
```

Tell Capybara to use it:

```
# features/support/env.rb

require 'persistent_selenium/driver'
Capybara.default_driver = :persistent_selenium
```

Should work just the same as if you used the standard Capybara Selenium driver, except for
these two differences:

* The browser starts up first thing and sticks around
* The last page you were on before your tests passed/failed stays there, so you can inspect it.

The browser's cookies and such are reset before the next test runs, so you still get the state
cleared out before your next set of tests.

### Under the hood

It's DRb, which Just Works (tm), and a little reshuffling of the default Capybara Selenium driver's code.

