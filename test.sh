echo '# Testing'

# ordinary test
echo '## Ordinary Testing'
go test -v tests/list_test.go

# benchmark test
echo '## Stress Testing'
go test tests/benchmark_ListAd_test.go --bench=.
