Русский | [English](README.md)
### Чтобы приступить к компиляции LineageOS 23.0 GSI,
Вам нужно будет ознакомиться с [Git and Repo](https://source.android.com/source/using-repo.html), [Как собрать GSI](https://github.com/phhusson/treble_experimentations/wiki/How-to-build-a-GSI%3F), а также с темой на 4pda по [Сборке Android из исходников](https://4pda.to/forum/index.php?showtopic=209610&view=findpost&p=6112304)


### Создайте директорию

В качестве первого шага вам нужно создать и войти папку с соответствующим именем
Для этого выполните следующие команды:

```bash
mkdir LineageOS
cd LineageOS
```

### Чтобы инициализировать локальный репозиторий, выполните эту команду:

```bash
repo init -u https://github.com/LineageOS/android.git -b lineage-23.0 --git-lfs
```


### Склонируйте манифест, чтобы добавить необходимые зависимости для gsi:

    git clone https://github.com/MisterZtr/treble_manifest.git .repo/local_manifests -b lineage-23.0


### После этого синхронизируйте исходный код, выполнив эту команду:

```bash
repo sync --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j4
```


### После синхронизации исходного кода, примените патчи:

Скопируйте папку patches в папку c прошивкой, а далее

```
bash patches/apply-patches.sh .
```

## Создания Makefile для сборки

 Клонируйте этот репозиторий, а затем в папке device/phh/treble, выполните следующие команды:,

 ```
cd device/phh/treble
bash generate.sh lineage
 ```

А так же, скопируйте в эту папку файлы treble_arm64_bgN.mk и treble_arm64_bvN.mk
 
 
### Используйте ccache, чтобы ускорить повторные сборки

Вы можете добавив эти строки в файл ~/.bashrc или ~/.zshrc, чтобы не вводить их снова:

```
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_MAXSIZE=50G # 50 GB
```

## Компиляция

В папке с исходниками, для ванильной версии:

 ```
. build/envsetup.sh
ccache -M 50G -F 0
lunch treble_arm64_bvN-bp2a-userdebug
make systemimage -j$(nproc --all)
 ```
 
Для версии с гугл сервисами:

 ```
. build/envsetup.sh
ccache -M 50G -F 0
lunch treble_arm64_bgN-bp2a-userdebug
make systemimage -j$(nproc --all)
 ```


## Сжатие

После компиляции,
Если вы хотите ужать полученный файл через терминал, я советую использовать [7-zip](https://aur.archlinux.org/packages/7-zip), для быстрого и безопасного способа
В папке с исходниками,

   ```
cd out/target/product/tdgsi_arm64_ab
7zz a system.img.xz "system.img"
   ```


## Устранение неполадок

Если у вас присутсвуют проблемы при применении патчей, примините эти патчи самостоятельно



## Благодарности
Эти люди так или иначе помогали проекту, поэтому именно они должны получить все почести:
- [LineageOS Team](https://github.com/LineageOS)
- [Phhusson](https://github.com/phhusson)
- [AndyYan](https://github.com/AndyCGYan)
- [Ponces](https://github.com/ponces)
- [Peter Cai](https://github.com/PeterCxy)
- [Iceows](https://github.com/Iceows)
- [ChonDoit](https://github.com/ChonDoit)
- [Nazim N ](https://github.com/naz664)
- [Ahnet](https://github.com/ahnet-69)
- [mytja](https://github.com/mytja)
- [cawilliamson](https://github.com/cawilliamson)
- [Doze-off](https://github.com/Doze-off)
