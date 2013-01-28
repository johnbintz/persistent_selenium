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

If you're using Cucumber, you can also install that hook:

``` bash
persistent_selenium install
```

Should work just the same as if you used the standard Capybara Selenium driver, except for
these two differences:

* The browser starts up first thing and sticks around, so you don't pay the startup/shutdown
  penalty with each test run.
* The last page you were on before your tests passed/failed stays there, so you can inspect it
  and adjust your tests.

The browser's cache is disabled, and cookies are reset before the next test runs, so you still get the state
cleared out before your next set of tests.

### Under the hood

It's DRb, which mostly Just Works (tm), and has a little reshuffling of the default Capybara Selenium driver's code.

#### When DRb doesn't Just Work (tm)

You may see recycled object errorrs. Capybara is complex enough that, eventually, something
will get garbage collected on the server and an object on the client will notice.
I turned off garbage collection on the server but it still happens.
Just rerun the test. It doesn't happen too often. It's the price you pay for speed.

