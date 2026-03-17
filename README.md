# Manual test cases

This repo hosts the manual test cases used for various Ubuntu-related images.

It's currently a dumb dump of what was hosted by the ISO tracker.

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
