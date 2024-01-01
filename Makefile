#
# Create container images
#

.PHONY: all
all: revenium-isotope-sandbox

.PHONY: image
image:
	docker buildx build \
	    -f Dockerfile \
	    -t ${IMAGE}:latest \
	    --target ${IMAGE} \
	    .

.PHONY: revenium-isotope-sandbox
revenium-isotope-sandbox:
	${MAKE} image IMAGE=$@

.PHONY: clean
clean:
	@echo "Run '${MAKE} veryclean'" \
	    "to remove the docker build cache"

.PHONY: veryclean
veryclean:
	docker builder prune
