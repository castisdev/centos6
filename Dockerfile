# Pull base image
FROM centos:6

# Install EPEL repo
RUN yum install -y epel-release; yum -y clean all

# Install
RUN yum install -y \
  sudo \
  wget \
  gcc \
  gcc-c++ \
  make \
  unzip \
  openssl-devel \
  git \
  subversion \
  tar \
  boost-devel \
  boost-static \
  glibc-devel \
  libuuid-devel \
  gdb \
  valgrind \
  mysql-devel \
  postgresql93-devel \
  curl-devel \
  xz \
  file \
  vim-enhanced \
  unixODBC-devel \
  mysql-connector-odbc \
  sysstat \
  yum-utils \
  gperftools-devel \
  golang; \
  yum -y clean all

# Install Intel TBB
RUN yum-config-manager -y --add-repo https://yum.repos.intel.com/tbb/setup/intel-tbb.repo; \
  yum install -y tbb-devel; \
  yum -y clean all

ADD install_devtoolset8.sh /script/
RUN /script/install_devtoolset8.sh
ENV PATH /opt/rh/devtoolset-8/root/usr/bin/:$PATH

ADD install_cmake3164.sh /script/
RUN /script/install_cmake3164.sh

ADD install_libbacktrace.sh /script/
RUN /script/install_libbacktrace.sh

ADD install_boost171.sh /script/
RUN /script/install_boost171.sh
ENV BOOST_ROOT /usr/local/boost_1_71_0

ADD install_cryptopp820.sh /script/
RUN /script/install_cryptopp820.sh

ADD install_googletest1100.sh /script/
RUN /script/install_googletest1100.sh

ADD install_openssl102u.sh /script/
RUN /script/install_openssl102u.sh

ADD install_python2717.sh /script/
RUN /script/install_python2717.sh

ADD install_python381.el6.sh /script/
RUN /script/install_python381.el6.sh

ADD install_cpptools.sh /script/
RUN /script/install_cpptools.sh

ADD install_cppcheck190.sh /script/
RUN /script/install_cppcheck190.sh

ADD install_zsh571.el6.sh /script/
RUN /script/install_zsh571.el6.sh

ADD install_ninja1100.sh /script/
RUN /script/install_ninja1100.sh

# set timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# ctail
RUN wget -O - https://raw.githubusercontent.com/castisdev/ctail/master/install.sh --no-check-certificate | bash

# Add root files
ADD .bashrc /root/.bashrc

# Set environment variables
ENV HOME /root

# Define default command
CMD ["scl", "enable", "devtoolset-8", "zsh"]
