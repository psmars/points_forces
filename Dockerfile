FROM absps/debian
MAINTAINER Pierre SMARS
LABEL tw.edu.yuntech.smars.version="0.2-beta" \
      tw.edu.yuntech.smars.release-date="2020-01-15"
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
	swig3.0 \
	libvtk6.3 \
	libvtk6-dev

RUN git clone https://git.code.sf.net/p/pointsforces/code src
RUN git clone https://github.com/vxl/vxl.git && \
	cp /root/src/core/scripts/man2cxx /usr/local/bin && \
	cd /root/src/core && \
	cmake . && \
	make && \
	make install && \
	cd /root/vxl && \
	cmake -D VXL_BUILD_CONTRIB=ON . && \
	make && \
	make install && \
	cd /root/src/survey && \
	cmake -D core_DIR=/usr/local/lib/points_forces . && \
	make && \
	make install && \
	cd /root && \
	rm -rf vxl

RUN /root/src/utils/preparetcl

ENV TCLLIBPATH=/usr/local/lib/points_forces

COPY .points_forcesrc /root
COPY .tclshrc /root
COPY .wishrc /root
RUN ln -s /usr/local/share/points_forces/scripts /root/.points_forces

CMD /bin/zsh

