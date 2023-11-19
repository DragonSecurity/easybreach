# Dragon Security EasyBreach
A password breach detection server

Rest API to check if a password is in a data breach. Works offline - everything stays on your machine! Database is not included. 
We also provide a downloader for the hibp database.

## Download our release
Our github actions releases automatically to https://github.com/DragonSecusrity/easybreach/releases

## Build from source
```
 cargo b -r
```

## Download hibp password hashes as Text File
If you really want a ~35GB text file with all the hashes
```
downloader --sink-stdout > pwned-passwords-sha1-ordered-by-hash-v20.txt
```
## Create your database
This is what the api uses, and the database is reduced to ~1.1Gb
```
downloader --sink-bloom-file=easybreach.bloom
```

## Is it safe?
EasyBreach does not need external network access. passwords and hashes are never leaving your server. Use the /hash/[SHA1] endpoint in production to avoid sending them through the network stack.

## How it works
EasyBreach checks passwords based on the password list provided by haveibeenpwned. We use a bloomfilter, so it is freaking fast. The bloomfilter is generated with a chance of 1% that you get false positives.

## Endpoints
### /pw/[blank_password]
You'll get a "secure":true if the password is not breached. use the /hash/ endpoint in production instead!
```
curl http://127.0.0.1:3342/pw/test
{"hash":"A94A8FE5CCB19BA61C4C0873D391E987982FBBD3","pw":"test","secure":false}
```

### /hash/[UPPERCASE(SHA1(blank_password))]
You'll get a "secure":true if the password is not breached.
```
curl http://127.0.0.1:3342/hash/0000000CAEF405439D57847A8657218C618160B2
{"hash":"A94A8FE5CCB19BA61C4C0873D391E987982FBBD3","pw":"test","secure":false}
```

### /check (POST)
In prod prefer POST, some tracing / logging / debug libs like to collecting url parameters.
```
curl -X POST http://127.0.0.1:3342/check -H 'Content-Type: application/json' -d '{"hash": "0000001C5F765AA063E4F8470451F85F7DB4ED3X"}'
```

## How fast is it?
I don't know, but the api is fast.
```
ab -n 20000 -c 100 http://127.0.0.1:3342/pw/test                                                                                                         !256
This is ApacheBench, Version 2.3 <$Revision: 1879490 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 2000 requests
Completed 4000 requests
Completed 6000 requests
Completed 8000 requests
Completed 10000 requests
Completed 12000 requests
Completed 14000 requests
Completed 16000 requests
Completed 18000 requests
Completed 20000 requests
Finished 20000 requests


Server Software:        
Server Hostname:        127.0.0.1
Server Port:            3342

Document Path:          /pw/test
Document Length:        78 bytes

Concurrency Level:      100
Time taken for tests:   0.963 seconds
Complete requests:      20000
Failed requests:        0
Total transferred:      3720000 bytes
HTML transferred:       1560000 bytes
Requests per second:    20771.43 [#/sec] (mean)
Time per request:       4.814 [ms] (mean)
Time per request:       0.048 [ms] (mean, across all concurrent requests)
Transfer rate:          3772.94 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    2   0.7      2       4
Processing:     1    3   0.7      2       5
Waiting:        0    1   0.7      1       4
Total:          2    5   0.5      5       6
WARNING: The median and mean for the processing time are not within a normal deviation
        These results are probably not that reliable.

Percentage of the requests served within a certain time (ms)

```