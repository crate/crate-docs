# Reformat JSON summary of Vale to CSV using jq.
# cat vale-summary.json | jq --raw-output --from-file vale-summary2csv.jq > vale-summary.csv

# Define header columns
["file", "errors", "warnings", "suggestions"],

# Define rows
(.[] | [.file, .errors, .warnings, .suggestions])

# Format as CSV
| @csv
