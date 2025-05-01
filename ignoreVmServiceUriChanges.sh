# regex:
# match: http://127.0.0.1:\d+/[-A-Za-z0-9+_]*=/
# changeTo: http://127.0.0.1:11327/AcNQSWDyl7s=/
sed 's/http:\/\/127\.0\.0\.1\:[0-9]\+\/[-A-Za-z0-9+_]*=\//http:\/\/127.0.0.1:11327\/AcNQSWDyl7s=\//' "$@"
