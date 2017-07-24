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
set -x

USER_ARGS="$@"


#client.parameter: -Dusers=100 -Dramps=1 -DsimulationClass=com.walmart.store.gatling.simulation.BasicSimulation    #the simulation class is required
##client.dataFeedPath: sample-feed.csv # path to the data feed file
#client.quiet: false
#client.parallelism: 1
#: 
#client.userName: Abiy
#client.remoteArtifact: false
#client.dataFeedFileName: search.csv #data feed file name

# Actor identifier  that is used to join the master/cluster
# update the host and port value to point to the cluster where the master is running on



: ${MASTER_IP:=""}
: ${SERVER_PORT:=10987}
: ${GATLING_TEST_JAR_NAME:=tests.jar}
: ${SIMULATION_CLASS:=""}
: ${SIMULATION_PARAMS:=""}
: ${CLIENT_PARALLELISM:=1}
: ${NUM_OF_ACTORS:=1}

GATLING_TEST_JAR="/workdir/gatling-tests/${GATLING_TEST_JAR_NAME}"

JAVA_OPTS="-server -XX:+UseThreadPriorities  -XX:ThreadPriorityPolicy=42 -Xms512M -Xmx512M -Xmn100M -XX:+HeapDumpOnOutOfMemoryError -XX:+AggressiveOpts -XX:+OptimizeStringConcat -XX:+UseFastAccessorMethods -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled "
JAVA_OPTS+="-Dakka.contact-points=${MASTER_IP}:2551 "
JAVA_OPTS+="-Dserver.url=http://${MASTER_IP}:8080 "
JAVA_OPTS+="-Dclient.jarPath=${GATLING_TEST_JAR} "
JAVA_OPTS+="-Dclient.jarFileName=${GATLING_TEST_JAR_NAME} "
JAVA_OPTS+="-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv6Addresses=false "
JAVA_OPTS+="-Dclient.parallelism=$CLIENT_PARALLELISM "
JAVA_OPTS+="-Dclient.numberOfActors=$NUM_OF_ACTORS "

export SPRING_CONFIG_NAME=/workdir/confs/config.yml
CLIENT_PATH="target/gatling-client-1.0.2-SNAPSHOT.jar"

ls -lah $GATLING_TEST_JAR
ls -lah /workdir/confs/config.yml

CLIENT_PARAM="-DsimulationClass=${SIMULATION_CLASS} ${SIMULATION_PARAMS}"

#echo "client.parameter: ${SIMULATION_PARAMS} -DsimulationClass=${SIMULATION_CLASS}" >> /workdir/confs/config.yml

# Run Gatling
java $JAVA_OPTS -Dclient.parameter="${SIMULATION_PARAMS} -DsimulationClass=${SIMULATION_CLASS}" -jar ${CLIENT_PATH} com.walmart.gatling.client.Client --spring.config.location=/workdir/confs/config.yml


#Example /bin/bash dist-gatling-client.sh -Dclient.userName=Command -Dclient.parallelism=1

