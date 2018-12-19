# cpu-load-blinkt-k8s
This is a collection of code, a Docker file, and Kubernetes `DaemonSet` for the Pimoroni Blinkt! light kit based on [dvdmuckle's](https://github.com/dvdmuckle/cpu-load-blinkt-k8s) work. The main tweaks are to have the lights change colour from green to red as the CPU ultilisation increases and for the pod to only run on the master node. 

Specific changes to the deamon set below, change the hostname to match your cluster:

	kind: DaemonSet
	apiVersion: extensions/v1beta1
	metadata:
	  namespace: kube-system
	  labels:
	    tier: master
	spec:
	  selector:
	    matchLabels:
	      name: cpu-load-blinkt
	  template:
	    spec:
	      serviceAccountName: cpu-load-blinkt-sa
	      nodeSelector:
	        kubernetes.io/hostname: shepherd
	      containers:
	      - name: cpu-load-blinkt
	        image: micedwards/arm-blinkt-cpuload
