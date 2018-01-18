A reproduction session for an issue with running pip with a remote wheel source.

```
$ ./setup.sh
Create a network...

Error response from daemon: network with name wheelhouse already exists

Build the containers...

Sending build context to Docker daemon   38.4kB
Step 1/7 : FROM python:2.7-slim
 ---> 4fd30fc83117
Step 2/7 : RUN apt-get update &&     apt-get install -y -q python-pip python-dev build-essential nginx curl
 ---> Using cache
 ---> 09da0786a4d3
Step 3/7 : RUN pip install -U pip &&     pip install -U wheel
 ---> Using cache
 ---> dd67ddb3d343
Step 4/7 : COPY requirements.txt .
 ---> Using cache
 ---> cb515e101307
Step 5/7 : RUN pip wheel     --wheel-dir=/var/www/html     -r requirements.txt
 ---> Using cache
 ---> 5dd92c833ad4
Step 6/7 : RUN ln -sf /dev/stdout /var/log/nginx/access.log     && ln -sf /dev/stderr /var/log/nginx/error.log
 ---> Using cache
 ---> d5dcdf81603f
Step 7/7 : CMD ["nginx", "-g", "daemon off;"]
 ---> Using cache
 ---> a63128cdf7e8
Successfully built a63128cdf7e8
Successfully tagged wheel-build:latest
Sending build context to Docker daemon  38.91kB
Step 1/4 : FROM python:2.7-slim
 ---> 4fd30fc83117
Step 2/4 : RUN pip install -U pip &&     pip install -U wheel
 ---> Using cache
 ---> 36a8a937b7bb
Step 3/4 : COPY requirements.txt .
 ---> Using cache
 ---> c56e1b86c67c
Step 4/4 : CMD pip install     --no-index     --trusted-host wheelhouse     --find-links=http://wheelhouse/     -vvv -r requirements.txt
 ---> Using cache
 ---> 48690577953d
Successfully built 48690577953d
Successfully tagged wheel-install:latest

Run the wheelhouse server...

7c532c9b6842ff170cc756e61954e1e08e6394297cb25dc046bdb6d45e851a8c

Verify that we can access one of the wheels...

HTTP/1.1 200 OK
Server: nginx/1.6.2
Date: Thu, 18 Jan 2018 13:55:38 GMT
Content-Type: application/octet-stream
Content-Length: 5908
Last-Modified: Thu, 18 Jan 2018 13:49:41 GMT
Connection: keep-alive
ETag: "5a60a5f5-1714"
Accept-Ranges: bytes

Now let's try installing using the wheel...

Ignoring indexes: https://pypi.python.org/simple
Collecting pytz==2014.10 (from -r requirements.txt (line 1))
  1 location(s) to search for versions of pytz:
  * http://wheelhouse/
  Skipping link http://wheelhouse/ (from -f); not a file
  Getting page http://wheelhouse/
  Starting new HTTP connection (1): wheelhouse
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Skipping link http://nginx.org/ (from http://wheelhouse/); not a file
    Skipping link http://bugs.debian.org/cgi-bin/pkgreport.cgi?ordering=normal;archive=0;src=nginx;repeatmerged=0 (from http://wheelhouse/); unsupported archive format: .cgi
  Could not find a version that satisfies the requirement pytz==2014.10 (from -r requirements.txt (line 1)) (from versions: )
Cleaning up...
No matching distribution found for pytz==2014.10 (from -r requirements.txt (line 1))
Exception information:
Traceback (most recent call last):
  File "/usr/local/lib/python2.7/site-packages/pip/basecommand.py", line 215, in main
    status = self.run(options, args)
  File "/usr/local/lib/python2.7/site-packages/pip/commands/install.py", line 335, in run
    wb.build(autobuilding=True)
  File "/usr/local/lib/python2.7/site-packages/pip/wheel.py", line 749, in build
    self.requirement_set.prepare_files(self.finder)
  File "/usr/local/lib/python2.7/site-packages/pip/req/req_set.py", line 380, in prepare_files
    ignore_dependencies=self.ignore_dependencies))
  File "/usr/local/lib/python2.7/site-packages/pip/req/req_set.py", line 554, in _prepare_file
    require_hashes
  File "/usr/local/lib/python2.7/site-packages/pip/req/req_install.py", line 278, in populate_link
    self.link = finder.find_requirement(self, upgrade)
  File "/usr/local/lib/python2.7/site-packages/pip/index.py", line 514, in find_requirement
    'No matching distribution found for %s' % req
DistributionNotFound: No matching distribution found for pytz==2014.10 (from -r requirements.txt (line 1))

The Nginx logs...

172.19.0.2 - - [18/Jan/2018:13:55:38 +0000] "HEAD /zencoder-0.6.5-py2-none-any.whl HTTP/1.1" 200 0 "-" "curl/7.38.0"
172.19.0.3 - - [18/Jan/2018:13:55:39 +0000] "GET / HTTP/1.1" 200 529 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"

Cleaup

Error response from daemon: network wheelhouse id 4720de53854a7cd2d3cc580f2ab29432a6f248634caffd60a91f143877ac23a6 has active endpoints
wheelhouse
Error: No such container: wheelhouse-consumer
```
