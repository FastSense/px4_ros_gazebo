**Docker branch**
--------------------
#### Подготовка
Работаем в Ubuntu 16.04

Установить в свою систему
```bash
sudo apt install python-wstool python-catkin-tools -y


$FASTSENSE_WORKSPACE_DIR - папка, в которую будут ставиться всякие модули, библиотеки и тд. Эта папка будет прокинута в докер
catkin_dir=$FASTSENSE_WORKSPACE_DIR/catkin_ws - каталог, в который будут ставиться пакеты для ROS
ros_packets_dir=$catkin_dir/src - смирись и прими, что у тебя должна быть папка src, иначе ничего не соберётся

# create Firmware dir 
mkdir $FASTSENSE_WORKSPACE_DIR/Firmware

# create catkin workspace
mkdir -p $ros_packets_dir
cd $catkin_dir
git clone git@github.com:FastSense/px4_ros_gazebo.git $ros_packets_src_dir

## Initialise wstool
wstool init $ros_packets_dir # создаёт скрытые файлы для workspace
```


#### Сборка образа

В папке $FASTSENSE_WORKSPACE_DIR/catkin_ws/src есть файл Dockerfile с инструкциями по сборке docker образа

* собирает образ со всеми нужными системными пакетами
* копирует скрипты из docker/ (локальная папка) в /src/scripts/ (внутри докера)

```bash
docker build . -t x_kinetic_img
```

#### Запуск контейнера

docker/docker_x.sh

    запускает контейнер, прокидывает папки 

                catkin_ws   <-> /home/user/catkin_ws        rw      код FastSense, работа с git в нем ведется локально (не в докере)
                Firmware    <-> /home/user/firmware         rw      код PX4 Firmware, локально надо только создать папку, далее работа через контейнер
                ~/.gazebo   <-> /home/user/.gazebo          rw      нужно для сохранения файлов миров чтобы долго не ждать 
                ~/.ssh      <-> /home/user/.ssh             rw      нужно для доступа к  github по ключу

    

```bash
./docker/docker_x.sh arg1 arg2
```

arg1 - имя образа (x_kinetic_img)
arg2 - код команды для запуска

arg2 = {make_firmware, bash}

Порядок вызовов:
- make_firmware
- bash

make_firmware 	- собрать px4 Firmware внутри контейнера
bash			- установить переменные среды для ROS и запустить bash терминал

Примеры запуска контейнера:
```bash
cd $FASTSENSE_WORKSPACE_DIR/catkin_ws/src
./docker/docker_x.sh x_kinetic_img make_firmware
./docker/docker_x.sh x_kinetic_img bash
```

внутри терминала bash, запущенного в контейнере:
```bash
cd /src/catkin_ws/
catkin build 								- собрать workspace
catkin clean								- почистить workspace 
roslaunch simple_goal simple_goal.launch 	- запустить тест
```
