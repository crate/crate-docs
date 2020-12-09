# Summarize JSON output of Vale using jq.
# cat vale-report.json | jq --from-file vale-summary.jq > vale-summary.json

to_entries | map({
    file: .key,
    errors: .value | [ .[] | select(.Severity | contains("error")) ] | length,
    warnings: .value | [ .[] | select(.Severity | contains("warning")) ] | length,
    suggestions: .value | [ .[] | select(.Severity | contains("suggestion")) ] | length,
})
