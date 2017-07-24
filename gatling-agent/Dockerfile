FROM openjdk:8u131-jdk

WORKDIR /workdir

RUN apt-get update && apt-get install -y --no-install-recommends \
		openjfx \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -fSsL -O https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/2.2.5/gatling-charts-highcharts-bundle-2.2.5-bundle.zip && \
    unzip gatling-charts-highcharts-bundle-2.2.5-bundle.zip && \
    rm gatling-charts-highcharts-bundle-2.2.5-bundle.zip

RUN mkdir -p /workdir/target

COPY target/gatling-agent-1.0.2-SNAPSHOT.jar /workdir/target/gatling-agent-1.0.2-SNAPSHOT.jar
COPY agent.sh /workdir/agent.sh

ENTRYPOINT ["/bin/bash", "/workdir/agent.sh"]
