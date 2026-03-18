# Manual test cases

This repo hosts the manual test cases used for various Ubuntu-related images.

Those tests are supposed to be human-readable only, so no particular format is
defined. Once completed, test results are supposed to be reported against the
tested artifact on <https://tests.ubuntu.com>.

## Repository structure

The repository is organised by Ubuntu release, with each release directory
following the same layout:

```
<release>/
├── products/          # One subdirectory per product (e.g. ubuntu-desktop, kubuntu)
│   └── <product>/     # Contains symlinks that point to relevant testsuites
└── testsuites/        # One subdirectory per testsuite
    └── <testsuite>/
        ├── Mandatory/ # Test cases that must be executed
        ├── Run-Once/  # Test cases that only need to run once (optional)
        └── Disabled/  # Test cases that are currently disabled
```

**Products** act as organisational containers. Each product directory holds
symbolic links into `testsuites/`, so a single testsuite can be referenced by
more than one product.

**Testsuites** hold the actual test-case files written in Markdown. Every test
case describes a step-by-step procedure together with the expected results.

## Contributing

Test cases are Markdown file. Many of them still contain the original HTML,
because the whole repo was too inconsistent for a mass conversion. Feel free to
manually convert them to proper Markdown on a case by case basis as you see fit.

Test suites are just folders of test cases. Feel free to copy-paste or symlink
(relative) across test suites to re-use existing test cases for multiple similar
products.

Product names are based on what's listed on <https://tests.ubuntu.com>, so
please don't update them without checking with the Release Team first. Inside
those high-level folders, you're free to do whatever you want as long as it
ends up in a testing story that not too technical people can follow to provide
test results.
