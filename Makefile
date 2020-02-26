cov:
	flutter test --coverage && genhtml -o coverage/doc coverage/lcov.info
	open "file://`pwd`/coverage/doc/index.html"