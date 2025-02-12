# Manual test cases

This repo hosts the test cases available on <https://iso.qa.ubuntu.com>.

## Writing a new test

* Create the new test file in one of the folder under `./testcases`
* DO NOT name the test with an ID in the filename, even though all the other
  testcases have one. This ID will be added when the test is deployed.
* Ask the release team to review and deploy your test, and add it to the right
  testsuite in the ISO tracker:
  * This deployment is done by using a command such as this:
    ```
    perl ./tools/qa_tracker_update.pl iso testcases/image/my_fancy_new_test
    ```
  * Once deployed, that `my_fancy_new_test` gets renamed with the corresponding
    ID in the database, which needs to be committed for later updates of that test.

## Updating a test

* Similar to writing a new one, except there is no renaming involved.
* Once updated and reviewed, the release team should update the ISO tracker
  with a similar command, and given that the file now has an ID, let's say
  `4000_my_fancy_new_test`, the script will update the database object instead of
  creating a new one.
