#!/usr/bin/env bash
#
# Copyright 2016
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# 		http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

USER_ARGS="$@"

: ${CONTACT_POINTS:="192.168.103.81:2551"}
: ${SERVER_PORT:=8090}
: ${NUM_ACTORS:=1}

JAVA_OPTS="-server -XX:+UseThreadPriorities  -XX:ThreadPriorityPolicy=42 -Xms1024M -Xmx1024M -Xmn100M -XX:+HeapDumpOnOutOfMemoryError -XX:+AggressiveOpts -XX:+OptimizeStringConcat -XX:+UseFastAccessorMethods -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv6Addresses=false -Dakka.contact-points=$CONTACT_POINTS -Dactor.port=0 -Dserver.port=$SERVER_PORT -Dactor.numberOfActors=$NUM_ACTORS ${USER_ARGS}"


GATLING_CLASSPATH="./target/gatling-agent-1.0.2-SNAPSHOT.jar"
# Run Gatling
java $JAVA_OPTS -jar ${GATLING_CLASSPATH} com.walmart.gatling.Application
