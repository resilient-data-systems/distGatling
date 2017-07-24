FROM openjdk:8u131-jdk

WORKDIR /workdir

RUN apt-get update && apt-get install -y --no-install-recommends \
		openjfx \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -fSsL -O https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/2.2.5/gatling-charts-highcharts-bundle-2.2.5-bundle.zip && \
    unzip gatling-charts-highcharts-bundle-2.2.5-bundle.zip && \
    rm gatling-charts-highcharts-bundle-2.2.5-bundle.zip

RUN mkdir -p /workdir/target
RUN mkdir -p /workdir/confs
RUN mkdir -p /workdir/gatling-tests

COPY target/gatling-client-1.0.2-SNAPSHOT.jar /workdir/target/gatling-client-1.0.2-SNAPSHOT.jar
COPY dist-gatling-client.sh /workdir/dist-gatling-client.sh
COPY confs/config.yml /workdir/confs/

ENTRYPOINT ["/bin/bash", "/workdir/dist-gatling-client.sh"]
