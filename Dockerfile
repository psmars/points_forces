FROM absps/debian_base:latest
MAINTAINER Pierre SMARS
LABEL tw.edu.yuntech.smars.version="0.11" \
      tw.edu.yuntech.smars.release-date="2022-09-13"
USER root
WORKDIR /root

RUN apt-get update && \
	apt-get install -y \
	gcc \
	g++ \
	cmake \
	flex \
	tcl \
	tcl-dev \
	tcl-tclreadline \
	tk \
	tk-dev \
	swig \
	libvtk9 \
	libvtk9-dev \
	gphoto2

RUN git clone https://git.code.sf.net/p/pointsforces/code src

RUN git clone https://github.com/vxl/vxl.git && \
	cp /root/src/core/scripts/man2cxx /usr/local/bin && \
	cd /root/src/core && \
	cmake -D CMAKE_BUILD_TYPE=Release . && \
	make && \
	make install && \
	cd /root/vxl && \
	cmake -D VXL_BUILD_CONTRIB=ON . && \
	make && \
	make install && \
	cd /root/src/survey && \
	cmake -D core_DIR=/usr/local/lib/points_forces -D CMAKE_BUILD_TYPE=Release . && \
	make && \
	make install && \
	cd /root/src/structure/scripts && \
	wget https://sourceforge.net/projects/pointsforces/files/calipous.png/download -O calipous.png && \
	cd /root/src/structure && \
	cmake -D core_DIR=/usr/local/lib/points_forces -D survey_DIR=/usr/local/lib/points_forces -D CMAKE_BUILD_TYPE=Release . && \
	make && \
	make install && \
	cd /root && \
	rm -rf vxl

RUN /root/src/utils/preparetcl

ENV TCLLIBPATH=/usr/local/lib/points_forces

COPY config/.points_forcesrc \ 
	config/.tclshrc \
	config/.wishrc \
	config/installf \
	/usr/share/absps/config/

RUN chmod 0700 /usr/share/absps/config/installf

EXPOSE 9000-9100

CMD /usr/share/absps/config/install && \
	/usr/share/absps/config/installf && \
  /usr/bin/zsh
