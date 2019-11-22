FROM px4io/px4-dev-ros-kinetic:2019-10-04
COPY docker/* /src/scripts/
RUN chmod +x  /src/scripts/*
