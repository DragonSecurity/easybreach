build_bloom:
	cargo run --release --bin easybreach_hibp_downloader -- --sink-bloom-file=easybreach.bloom

run_release:
	cargo run --release --bin easybreach

build-easybreach_bloom:
	cp easybreach.bloom .docker/easybreach_bloom_001/easybreach.bloom
	cd .docker/easybreach_bloom_001 && docker build -t dragonsecurity/easybreach_bloom_001:v1 .
	rm .docker/easybreach_bloom_001/easybreach.bloom
	# docker push dragonsecurity/easybreach_bloom_001:v1