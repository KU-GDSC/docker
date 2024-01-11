FROM alpine:3.12.1
RUN apk add build-base git python2 python2-dev

# Download GDC
RUN git clone https://github.com/mathii/gdc /tmp/gdc
RUN cd /tmp/gdc/ && git checkout f3adb68
RUN chmod a+x /tmp/gdc/*.py
RUN python -m ensurepip --upgrade
RUN pip install git+https://github.com/mathii/pyEigenstrat.git@18eb725cbe2543063bb7b317a42499838d78a698
RUN pip install numpy

FROM alpine:3.12.1
RUN apk add python2 bash
COPY --from=0 /usr/lib/python2.7 /usr/lib/python2.7
COPY --from=0 /tmp/gdc/gdc* /usr/lib/python2.7
COPY --from=0 /tmp/gdc/*.py /usr/local/bin/
RUN sed -i '1s/^/\#\!\/usr\/bin\/python\n/' /usr/local/bin/*.py