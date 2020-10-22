# Copyright 2016 The Kubernetes Authors.
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM gcr.io/google-appengine/debian9

ENV NFS_VERSION 1:1.3.4-2.1

ENV C2D_RELEASE 1.3.4

RUN set -x && \
    apt-get update && apt-get install -qq -y nfs-kernel-server=${NFS_VERSION}* && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /exports

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +rx /usr/local/bin/docker-entrypoint.sh

VOLUME /exports

EXPOSE 111/tcp
EXPOSE 111/udp
EXPOSE 2049/tcp
EXPOSE 2049/udp
EXPOSE 20048/tcp

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/exports"]

