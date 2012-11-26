Now you can keep that precious browser window open when doing continuous integration testing.
Save seconds, and sanity, with every test re-run!

Also, the browser stays open at its last state so you can inspect it and fix your tests and/or code.

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

Copyright © 2012 John Bintz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
