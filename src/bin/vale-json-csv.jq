# Process Vale report into CSV summary

# Example:
#
# $ cat vale-summary.json | \
#       jq --raw-output --from-file vale-json-csv.jq > vale-summary.csv


# Define header columns
["file", "errors", "warnings", "suggestions"],

# Define rows
(.[] | [.file, .errors, .warnings, .suggestions])

# Format as CSV
| @csv

