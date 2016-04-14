"""
Python client for Kubernetes

This Python module as fetched from https://github.com/eldarion-gondor/pykube
commit 248af889905f2b54d4e4ce79e683b7e3fdd0e1a2 from 2016-04-14

This code is redistributed under the Apache License, Version 2.0.

Thank you, eldarion-gondor, for providing this library.
"""

from .config import KubeConfig  # noqa
from .exceptions import KubernetesError, PyKubeError, ObjectDoesNotExist  # noqa
from .http import HTTPClient  # noqa
from .objects import (  # noqa
    ConfigMap,
    DaemonSet,
    Deployment,
    Endpoint,
    Ingress,
    Job,
    Namespace,
    Node,
    Pod,
    ReplicationController,
    Secret,
    Service,
)
from .query import now, all_ as all, everything  # noqa
