## How to contribute to jsonapi_rspec

#### **Did you find a bug?**

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](<%= @tags.project_issues_url %>).

* If you're unable to find an open issue addressing the problem, [open a new one](<%= @tags.project_new_issue_url %>). Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

#### **Did you write a patch that fixes a bug?**

* Open a new GitHub pull request with the patch.

* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.

* Before submitting, please read run [Rubocop](http://batsov.com/rubocop/) on your code. If your PR fails our Rubocop convensions defined in `.rubocop.yml`, it will likely be rejected on those grounds.

* Ensure that you write RSpec tests that cover any new or modified code. PR's without spec coverage will likely be rejected.

#### **Did you fix whitespace, format code, or make a purely cosmetic patch?**

Changes that are cosmetic in nature and do not add anything substantial to the stability, functionality, or testability of <%= @tags.project_name_titleized %> will generally not be accepted.

Thanks for any contributions!

--Midwire
