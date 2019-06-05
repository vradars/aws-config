#!/bin/bash
#
# Set instance type
#INSTANCE="ami"

echo "Time"
date -u
INSTANCE="ubuntu"
WEBSITENAME="web"
#
#
echo " -------------------------------------------------------------------"
echo " ----------                Instance Type                      ------"
echo " -------------------------------------------------------------------"
echo $INSTANCE
echo " -------------------------------------------------------------------"
echo " -------------------------------------------------------------------"
if [ "$INSTANCE" == "ami" ]; then
	UNAMEX="ec2-user"
elif [ "$INSTANCE" == "ubuntu" ]; then
	UNAMEX="abby"
	HOME="/home/abby"
else
	echo "Instance Type does not exist in config_bash script - please update it."
fi
echo " -------------------------------------------------------------------"
echo " ----------                   User Name                       ------"
echo " -------------------------------------------------------------------"
echo $UNAMEX
echo " -------------------------------------------------------------------"
echo " -------------------------------------------------------------------"
cd /home/$UNAMEX
echo "Now in /home/$UNAMEX"
if [ "$INSTANCE" == "ami" ]; then
	sudo yum update -y
	sudo yum install -y git
	sudo yum install -y mesa-libGL
	sudo yum install -y mesa-libGL-devel
	sudo yum install -y mesa-libGLES
  sudo yum install -y mesa-libGLES-devel
  sudo yum install -y xorg-x11-server-Xvfb
  sudo yum groupinstall -y  "Development Tools"
elif [ "$INSTANCE" == "ubuntu" ]; then
	sudo apt-get update -y
	sudo apt-get install -y libgl1
	sudo apt-get install -y libxt6
	sudo apt-get install -y build-essential
	sudo apt-get install -y cmake-curses-gui
	sudo apt-get install -y xvfb
	sudo apt-get install -y nodejs npm
	sudo npm i -g npx
  sudo apt-get install -y freeglut3-dev
	sudo apt-get install -y libblas-dev liblapack-dev
	sudo apt-get install -y openmpi-bin openmpi-common libopenmpi-dev
#
	sudo apt-get install -y python3-pip
	sudo pip3 install numpy matplotlib
	sudo apt-get install -y autotools-dev
	sudo apt-get install -y automake
  sudo apt-get install -y libpcre3-dev
	sudo apt-get install -y bison
	sudo apt-get install -y byacc
	sudo apt-get install -y libfreetype6-dev
	sudo apt-get install -y pkg-config
  sudo apt-get install -y libfontconfig1-dev
  sudo apt-get install -y mdm
	#sudo apt-get install -y mayavi2
else
	echo "Instance Type does not exist in config_bash script - please update it."
fi
echo "alias l='ls -ltr' " >> /home/$UNAMEX/.bash_profile
echo "alias h='history' " >> /home/$UNAMEX/.bash_profile
echo "alias python='python3' " >> /home/$UNAMEX/.bash_profile
source /home/$UNAMEX/.bash_profile
sleep 5
/usr/bin/ncpus
NCPUS_VAR = $(ncpus)
echo "ncpus = $NCPUS_VAR"
echo " -------------------------------------------------------------------"
echo " ----------       Finished Installing Essential Dev Tools     ------"
echo " -------------------------------------------------------------------"

echo "End time of dev tools installation"
date -u

cd /home/$UNAMEX
git clone https://github.com/swig/swig.git
cd swig
./autogen.sh
./configure
make -j8
sudo make install
echo " -------------------------------------------------------------------"
echo " ----------              Finished Installing Swig             ------"
echo " -------------------------------------------------------------------"

echo "end time of installing swig"
date -u

cd /home/$UNAMEX
git clone https://github.com/tpaviot/oce.git
cd oce
mkdir build
cd build
cmake ..
make -j8
sudo make install
echo "PATH=$PATH:/usr/local/bin" >> /home/$UNAMEX/.bash_profile
echo "export PATH" >> /home/$UNAMEX/.bash_profile
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> /home/$UNAMEX/.bash_profile
source /home/$UNAMEX/.bash_profile
echo " -------------------------------------------------------------------"
echo " ----------               Finished Installing OCE             ------"
echo " -------------------------------------------------------------------"

echo "end time of installing oce"
date -u

cd /home/$UNAMEX
sleep 20
git clone https://github.com/PSUCompBio/pythonocc-core.git
if [ $? -eq 0 ]; then
  echo OK
else
  echo FAIL
	git clone git://github.com/PSUCompBio/pythonocc-core
fi
cd pythonocc-core
mkdir build
cd build
cmake .. -DPYTHONOCC_INSTALL_DIRECTORY:PATH=/usr/lib/python3.6/dist-packages/OCC
make -j8
sudo make install
echo " -------------------------------------------------------------------"
echo " ----------      Finished Installing Python OCC Core          ------"
echo " -------------------------------------------------------------------"

echo "end time of installing occ core"
date -u

cd /home/$UNAMEX
# specify anaconda or miniconda
#CONDAVAR="miniconda"
#wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O ~/$CONDAVAR.sh
# chmod +x Miniconda-latest-Linux-x86_64.sh
#./Miniconda-latest-Linux-x86_64.sh -b
# wget https://repo.continuum.io/archive/Anaconda2-4.1.1-Linux-x86_64.sh -O ~/$CONDAVAR.sh
#bash ~/$CONDAVAR.sh -b -p /home/$UNAMEX/$CONDAVAR
#echo "PATH=$PATH:/home/$UNAMEX/$CONDAVAR/bin" >> /home/$UNAMEX/.bash_profile
#echo "export PATH" >> /home/$UNAMEX/.bash_profile
#/home/$UNAMEX/$CONDAVAR/bin/conda install -y -c conda-forge -c dlr-sc -c pythonocc -c oce pythonocc-core==0.17 python=2.7
#echo " -------------------------------------------------------------------"
#echo " ----------      Finished Installing Anaconda and OCC         ------"
#echo " -------------------------------------------------------------------"
if [ "$INSTANCE" == "ami" ]; then
#	conda install anaconda vtk
#	/home/$UNAMEX/$CONDAVAR/bin/pip install vtk
	sudo pip3 install vtk
elif [ "$INSTANCE" == "ubuntu" ]; then
	#conda install anaconda vtk
	sudo pip3 install vtk
fi
echo " -------------------------------------------------------------------"
echo " ----------      Finished Installing VTK for python             ----"
echo " -------------------------------------------------------------------"
cd /home/$UNAMEX
git clone https://github.com/PSUCompBio/rbf-brain
git clone https://github.com/mathLab/PyGeM
cp /home/$UNAMEX/rbf-brain/__init__.py /home/$UNAMEX/PyGeM/pygem
cd /home/$UNAMEX/PyGeM
#source /home/$UNAMEX/.bashrc
#/home/$UNAMEX/$CONDAVAR/bin/python2 setup.py install
sudo python3 setup.py install
#/home/$UNAMEX/$CONDAVAR/bin/pip install --upgrade pip
#/home/$UNAMEX/$CONDAVAR/bin/pip install runipy
sudo pip3 install runipy
cd /home/$UNAMEX
echo " -------------------------------------------------------------------"
echo " ----------         Finished Installing PyGem                 ------"
echo " -------------------------------------------------------------------"

echo "end time of installinf pygem"
date -u

cp /home/$UNAMEX/rbf-brain/RBFfinal.ipynb /home/$UNAMEX/PyGeM/tutorials/
cp /home/$UNAMEX/rbf-brain/RBFfinal.py /home/$UNAMEX/PyGeM/tutorials/
cp /home/$UNAMEX/rbf-brain/initialmesh.vtk /home/$UNAMEX/PyGeM/tests/test_datasets/
cp /home/$UNAMEX/rbf-brain/parameters_rbf_custom.prm /home/$UNAMEX/PyGeM/tests/test_datasets/
echo " -------------------------------------------------------------------"
echo " ----------               Complete RBF Setup                  ------"
echo " -------------------------------------------------------------------"

echo "end time : pygem"
date -u

git clone https://github.com/PSUCompBio/vtk-image-write
cd vtk-image-write
xvfb-run --server-args="-screen 0 1024x768x24" python3 write-image.py
echo " -------------------------------------------------------------------"
echo " ----------             Complete Image Write Test              ------"
echo " -------------------------------------------------------------------"
cd /home/$UNAMEX
git clone https://github.com/Kitware/VTK
export VTK_ROOT=/home/$UNAMEX/VTK
cd $VTK_ROOT
mkdir build
cd build
cmake ../ -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release
make -j8:
cd /home/$UNAMEX
echo "export LD_LIBRARY_PATH=$VTK_ROOT/build/bin:$VTK_ROOT/build/lib:$LD_LIBRARY_PATH" >> /home/$UNAMEX/.bash_profile
source /home/$UNAMEX/.bash_profile

echo "end time:vtk install"
date -u

echo " -------------------------------------------------------------------"
echo " ----------               Complete VTK Install                ------"
echo " -------------------------------------------------------------------"
cd /home/$UNAMEX
git clone https://github.com/PSUCompBio/FemTech
cd FemTech
mkdir build
cd build
cmake .. -DEXAMPLES=ON -DEXAMPLE12=ON -DEXAMPLE7=ON -DEXAMPLE9=ON
make -j8
echo " -------------------------------------------------------------------"
echo " ----------           Complete FemTech Install                ------"
echo " -------------------------------------------------------------------"
cd /home/$UNAMEX
git clone https://github.com/PSUCompBio/MergePolyData
cd MergePolyData
mkdir build
cd build
cmake .. -DVTK_DIR=$VTK_ROOT/build
make -j8
echo " -------------------------------------------------------------------"
echo " ----------       Complete MergePolyData Install              ------"
echo " -------------------------------------------------------------------"
cd /home/$UNAMEX
npx create-react-app $WEBSITENAME
cd /home/$UNAMEX/$WEBSITENAME
npm run build
echo " -------------------------------------------------------------------"
echo " ----------           Complete Creating React Website         ------"
echo " -------------------------------------------------------------------"
cd /home/$UNAMEX
sudo chown -R $UNAMEX *
echo " -------------------------------------------------------------------"
echo " ----------            Complete Assigning Permissions         ------"
echo " -------------------------------------------------------------------"
echo "Initiation script complete! See /var/log/cloud-init-output.log for install log." >> InstallComplete
sudo chown -R $UNAMEX InstallComplete