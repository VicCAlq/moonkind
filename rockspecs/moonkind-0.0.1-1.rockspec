local package_name = "moonkind"
local package_version = "0.0.1"
local rockspec_revision = "1"
local github_account_name = "VicCAlq"
local github_repo_name = package_name
local git_checkout = package_version == "dev" and "main" or package_version

package = package_name
version = package_version .. "-" .. rockspec_revision
