#
# Create container images
#

.PHONY: all
all: rm-isotope-sandbox

.PHONY: image
image:
	docker buildx build \
	    -f Dockerfile \
	    -t ${IMAGE}:latest \
	    --target ${IMAGE} \
	    .

.PHONY: rm-isotope-sandbox
rm-isotope-sandbox:
	${MAKE} image IMAGE=$@

.PHONY: clean
clean:
	@echo "Run '${MAKE} veryclean'" \
	    "to remove the docker build cache"

.PHONY: veryclean
veryclean:
	docker builder prune
