An example of how to use `pip wheel` to speed up `pip install`.

The gotcha here is that in order to serve the content, you need to have directory listing on for the target, or alternatively, generate an index as we're doing in this example.

```
Create a network...

Error response from daemon: network with name wheelhouse already exists

Build the containers...

Sending build context to Docker daemon  70.14kB
Step 1/8 : FROM python:2.7-slim
 ---> 4fd30fc83117
Step 2/8 : RUN apt-get update &&     apt-get install -y -q python-pip python-dev build-essential nginx curl tree
 ---> Using cache
 ---> 3e7cb60f26b8
Step 3/8 : RUN pip install -U pip &&     pip install -U wheel
 ---> Using cache
 ---> cc1dbff4d349
Step 4/8 : COPY requirements.txt .
 ---> Using cache
 ---> d94d8e863d6c
Step 5/8 : RUN pip wheel     --wheel-dir=/var/www/html     -r requirements.txt
 ---> Using cache
 ---> 40484f31dd76
Step 6/8 : RUN cd /var/www/html && tree -H '.' -L 1 --noreport --charset utf-8 -P "*.whl" > index.html
 ---> Using cache
 ---> b9298ebd6c4f
Step 7/8 : RUN ln -sf /dev/stdout /var/log/nginx/access.log     && ln -sf /dev/stderr /var/log/nginx/error.log
 ---> Using cache
 ---> 6fc14d14b270
Step 8/8 : CMD ["nginx", "-g", "daemon off;"]
 ---> Using cache
 ---> 0aa9b7b7fe9c
Successfully built 0aa9b7b7fe9c
Successfully tagged wheel-build:latest
Sending build context to Docker daemon  71.17kB
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

a65fff7aff636009ad4685bf452571eb23079353b7860cf48f41900c1942568c

Verify that we can access one of the wheels...

HTTP/1.1 200 OK
Server: nginx/1.6.2
Date: Thu, 18 Jan 2018 15:54:49 GMT
Content-Type: application/octet-stream
Content-Length: 5908
Last-Modified: Thu, 18 Jan 2018 15:47:43 GMT
Connection: keep-alive
ETag: "5a60c19f-1714"
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
    Skipping link http://wheelhouse/contextlib2-0.5.5-py2.py3-none-any.whl (from http://wheelhouse/); wrong project name (not pytz)
    Found link http://wheelhouse/pytz-2014.10-py2.py3-none-any.whl (from http://wheelhouse/), version: 2014.10
    Skipping link http://wheelhouse/pyzmq-17.0.0b1-cp27-cp27mu-manylinux1_x86_64.whl (from http://wheelhouse/); wrong project name (not pytz)
    Skipping link http://wheelhouse/raven-6.0.0-py2.py3-none-any.whl (from http://wheelhouse/); wrong project name (not pytz)
    Skipping link http://wheelhouse/requests-2.7.0-py2.py3-none-any.whl (from http://wheelhouse/); wrong project name (not pytz)
    Skipping link http://wheelhouse/stripe-1.75.3-py2-none-any.whl (from http://wheelhouse/); wrong project name (not pytz)
    Skipping link http://wheelhouse/urllib3-1.10.2-py2-none-any.whl (from http://wheelhouse/); wrong project name (not pytz)
    Skipping link http://wheelhouse/zencoder-0.6.5-py2-none-any.whl (from http://wheelhouse/); wrong project name (not pytz)
  Using version 2014.10 (newest of versions: 2014.10)
  "GET /pytz-2014.10-py2.py3-none-any.whl HTTP/1.1" 200 477007
  Downloading http://wheelhouse/pytz-2014.10-py2.py3-none-any.whl (477kB)
  Downloading from URL http://wheelhouse/pytz-2014.10-py2.py3-none-any.whl (from http://wheelhouse/)
Collecting pyzmq==17.0.0b1 (from -r requirements.txt (line 2))
  1 location(s) to search for versions of pyzmq:
  * http://wheelhouse/
  Getting page http://wheelhouse/
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Skipping link http://wheelhouse/pytz-2014.10-py2.py3-none-any.whl (from http://wheelhouse/); wrong project name (not pyzmq)
    Found link http://wheelhouse/pyzmq-17.0.0b1-cp27-cp27mu-manylinux1_x86_64.whl (from http://wheelhouse/), version: 17.0.0b1
  Using version 17.0.0b1 (newest of versions: 17.0.0b1)
  "GET /pyzmq-17.0.0b1-cp27-cp27mu-manylinux1_x86_64.whl HTTP/1.1" 200 2992411
  Downloading http://wheelhouse/pyzmq-17.0.0b1-cp27-cp27mu-manylinux1_x86_64.whl (3.0MB)
  Downloading from URL http://wheelhouse/pyzmq-17.0.0b1-cp27-cp27mu-manylinux1_x86_64.whl (from http://wheelhouse/)
Collecting raven==6.0.0 (from -r requirements.txt (line 3))
  1 location(s) to search for versions of raven:
  * http://wheelhouse/
  Getting page http://wheelhouse/
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Found link http://wheelhouse/raven-6.0.0-py2.py3-none-any.whl (from http://wheelhouse/), version: 6.0.0
  Using version 6.0.0 (newest of versions: 6.0.0)
  "GET /raven-6.0.0-py2.py3-none-any.whl HTTP/1.1" 200 279075
  Downloading http://wheelhouse/raven-6.0.0-py2.py3-none-any.whl (279kB)
  Downloading from URL http://wheelhouse/raven-6.0.0-py2.py3-none-any.whl (from http://wheelhouse/)
Collecting requests==2.7.0 (from -r requirements.txt (line 4))
  1 location(s) to search for versions of requests:
  * http://wheelhouse/
  Getting page http://wheelhouse/
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Found link http://wheelhouse/requests-2.7.0-py2.py3-none-any.whl (from http://wheelhouse/), version: 2.7.0
  Using version 2.7.0 (newest of versions: 2.7.0)
  "GET /requests-2.7.0-py2.py3-none-any.whl HTTP/1.1" 200 470641
  Downloading http://wheelhouse/requests-2.7.0-py2.py3-none-any.whl (470kB)
  Downloading from URL http://wheelhouse/requests-2.7.0-py2.py3-none-any.whl (from http://wheelhouse/)
Collecting stripe==1.75.3 (from -r requirements.txt (line 5))
  1 location(s) to search for versions of stripe:
  * http://wheelhouse/
  Getting page http://wheelhouse/
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Found link http://wheelhouse/stripe-1.75.3-py2-none-any.whl (from http://wheelhouse/), version: 1.75.3
  Using version 1.75.3 (newest of versions: 1.75.3)
  "GET /stripe-1.75.3-py2-none-any.whl HTTP/1.1" 200 203150
  Downloading http://wheelhouse/stripe-1.75.3-py2-none-any.whl (203kB)
  Downloading from URL http://wheelhouse/stripe-1.75.3-py2-none-any.whl (from http://wheelhouse/)
Collecting urllib3==1.10.2 (from -r requirements.txt (line 6))
  1 location(s) to search for versions of urllib3:
  * http://wheelhouse/
  Getting page http://wheelhouse/
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Found link http://wheelhouse/urllib3-1.10.2-py2-none-any.whl (from http://wheelhouse/), version: 1.10.2
  Using version 1.10.2 (newest of versions: 1.10.2)
  "GET /urllib3-1.10.2-py2-none-any.whl HTTP/1.1" 200 77473
  Downloading http://wheelhouse/urllib3-1.10.2-py2-none-any.whl (77kB)
  Downloading from URL http://wheelhouse/urllib3-1.10.2-py2-none-any.whl (from http://wheelhouse/)
Collecting zencoder==0.6.5 (from -r requirements.txt (line 7))
  1 location(s) to search for versions of zencoder:
  * http://wheelhouse/
  Getting page http://wheelhouse/
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Found link http://wheelhouse/zencoder-0.6.5-py2-none-any.whl (from http://wheelhouse/), version: 0.6.5
  Using version 0.6.5 (newest of versions: 0.6.5)
  "GET /zencoder-0.6.5-py2-none-any.whl HTTP/1.1" 200 5908
  Downloading http://wheelhouse/zencoder-0.6.5-py2-none-any.whl
  Downloading from URL http://wheelhouse/zencoder-0.6.5-py2-none-any.whl (from http://wheelhouse/)
Collecting contextlib2 (from raven==6.0.0->-r requirements.txt (line 3))
  1 location(s) to search for versions of contextlib2:
  * http://wheelhouse/
  Getting page http://wheelhouse/
  "GET / HTTP/1.1" 200 None
  Analyzing links from page http://wheelhouse/
    Found link http://wheelhouse/contextlib2-0.5.5-py2.py3-none-any.whl (from http://wheelhouse/), version: 0.5.5
  Using version 0.5.5 (newest of versions: 0.5.5)
  "GET /contextlib2-0.5.5-py2.py3-none-any.whl HTTP/1.1" 200 8134
  Downloading http://wheelhouse/contextlib2-0.5.5-py2.py3-none-any.whl
  Downloading from URL http://wheelhouse/contextlib2-0.5.5-py2.py3-none-any.whl (from http://wheelhouse/)
Installing collected packages: pytz, pyzmq, contextlib2, raven, requests, stripe, urllib3, zencoder




  changing mode of /usr/local/bin/raven to 755




Successfully installed contextlib2-0.5.5 pytz-2014.10 pyzmq-17.0.0b1 raven-6.0.0 requests-2.7.0 stripe-1.75.3 urllib3-1.10.2 zencoder-0.6.5
Cleaning up...

The Nginx logs...

172.19.0.2 - - [18/Jan/2018:15:54:49 +0000] "HEAD /zencoder-0.6.5-py2-none-any.whl HTTP/1.1" 200 0 "-" "curl/7.38.0"
172.19.0.3 - - [18/Jan/2018:15:54:50 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:50 +0000] "GET /pytz-2014.10-py2.py3-none-any.whl HTTP/1.1" 200 477007 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:50 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:50 +0000] "GET /pyzmq-17.0.0b1-cp27-cp27mu-manylinux1_x86_64.whl HTTP/1.1" 200 2992411 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET /raven-6.0.0-py2.py3-none-any.whl HTTP/1.1" 200 279075 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET /requests-2.7.0-py2.py3-none-any.whl HTTP/1.1" 200 470641 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET /stripe-1.75.3-py2-none-any.whl HTTP/1.1" 200 203150 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET /urllib3-1.10.2-py2-none-any.whl HTTP/1.1" 200 77473 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET /zencoder-0.6.5-py2-none-any.whl HTTP/1.1" 200 5908 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET / HTTP/1.1" 200 1031 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"
172.19.0.3 - - [18/Jan/2018:15:54:51 +0000] "GET /contextlib2-0.5.5-py2.py3-none-any.whl HTTP/1.1" 200 8134 "-" "pip/9.0.1 {\x22cpu\x22:\x22x86_64\x22,\x22distro\x22:{\x22id\x22:\x22jessie\x22,\x22libc\x22:{\x22lib\x22:\x22glibc\x22,\x22version\x22:\x222.19\x22},\x22name\x22:\x22Debian GNU/Linux\x22,\x22version\x22:\x228\x22},\x22implementation\x22:{\x22name\x22:\x22CPython\x22,\x22version\x22:\x222.7.14\x22},\x22installer\x22:{\x22name\x22:\x22pip\x22,\x22version\x22:\x229.0.1\x22},\x22openssl_version\x22:\x22OpenSSL 1.0.1t  3 May 2016\x22,\x22python\x22:\x222.7.14\x22,\x22system\x22:{\x22name\x22:\x22Linux\x22,\x22release\x22:\x224.9.60-linuxkit-aufs\x22}}"

Cleaup

Error response from daemon: network wheelhouse id 4720de53854a7cd2d3cc580f2ab29432a6f248634caffd60a91f143877ac23a6 has active endpoints
wheelhouse
Error: No such container: wheelhouse-consumer
```
