FROM scratch

ARG NAME="artemiscloud/activemq-artemis-operator-bundle"
ARG VERSION="1"
ARG DESCRIPTION="ActiveMQ Artemis Operator Bundle"
ARG SUMMARY="ActiveMQ Artemis Operator Bundle"
ARG MAINTAINER="Roddie Kieley <rkieley@redhat.com>"
ARG REDHAT_OPENSHIFT_VERSION="v4.6"
ARG REDHAT_COMPONENT="activemq-artemis-operator-bundle-container"
ARG OPENSHIFT_TAGS="messaging,artemis,integration,operator,golang"
ARG K8S_DISPLAY_NAME="ActiveMQ Artemis Operator Bundle"
ARG K8S_DESCRIPTION="ActiveMQ Artemis Operator Bundle"
ARG OPERATOR_PACKAGE="activemq-artemis"

LABEL operators.operatorframework.io.bundle.mediatype.v1=registry+v1
LABEL operators.operatorframework.io.bundle.manifests.v1=manifests/
LABEL operators.operatorframework.io.bundle.metadata.v1=metadata/
LABEL operators.operatorframework.io.bundle.package.v1=$OPERATOR_PACKAGE
LABEL operators.operatorframework.io.bundle.channels.v1=current
LABEL operators.operatorframework.io.bundle.channel.default.v1=current

COPY manifests /manifests/
COPY metadata /metadata/

LABEL com.redhat.component=$REDHAT_COMPONENT
LABEL com.redhat.delivery.operator.bundle="true"
LABEL com.redhat.openshift.versions=$REDHAT_OPENSHIFT_VERSION
LABEL description=$DESCRIPTION
LABEL io.k8s.description=$K8S_DESCRIPTION
LABEL io.k8s.display-name=$K8S_DISPLAY_NAME
LABEL io.openshift.tags=$OPENSHIFT_TAGS
LABEL maintainer=$MAINTAINER
LABEL name=$NAME
LABEL summary=$SUMMARY
LABEL version=$VERSION
