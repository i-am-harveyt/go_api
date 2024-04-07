echo '# Testing'

# ordinary test
echo '## Ordinary Testing'
go test -v tests/CreateAd_test.go
go test -v tests/ListAd_test.go

# benchmark test
echo '## Stress Testing'
go test tests/benchmark_ListAd_test.go --bench=.
go test tests/benchmark_CreateAd_test.go --bench=.
