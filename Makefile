build: Dockerfile
	docker build -t absps/points_forces .

run:
	docker run -it --rm -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix --hostname points_forces --name pf_container absps/points_forces

push:
	docker push absps/points_forces

clean:
	rm -rf *~

