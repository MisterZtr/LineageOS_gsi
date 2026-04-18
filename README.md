English | [Русский](README-RU.md)
### To get started with building LineageOS 23.2 GSI,
You'll need to get familiar with [Git and Repo](https://source.android.com/source/using-repo.html) as well as [How to build a GSI](https://github.com/phhusson/treble_experimentations/wiki/How-to-build-a-GSI%3F).

### Create the directories

As a first step, you'll have to create and enter a folder with the appropriate name
To do that, run these commands:

```bash
mkdir LineageOS
cd LineageOS
```

### To initialize your local repository, run this command:

```bash
repo init -u https://github.com/LineageOS/android.git -b lineage-23.2 --git-lfs
```

### Clone the Manifest to add necessary dependencies for gsi:
 
    git clone https://github.com/MisterZtr/treble_manifest.git .repo/local_manifests -b lineage-23.2
  
### Afterwards, sync the source by running this command:

```bash
repo sync --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j4
```

### Next, apply patches:


```
bash LineageOS_gsi/patches/apply-patches.sh .
```

### Turn on caching to speed up build

You can speed up subsequent builds by adding these lines to your ~/.bashrc OR ~/.zshrc file:

```
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_MAXSIZE=50G # 50 GB
``` 

### Compilation 

VANILLA version with erofs:

 ```
. build/envsetup.sh
ccache -M 50G -F 0
breakfast lineage_arm64_bvNE-bp4a-userdebug
make systemimage -j$(nproc --all)
 ```
 
VANILLA version with ext4:

 ```
. build/envsetup.sh
ccache -M 50G -F 0
breakfast lineage_arm64_bvN4-bp4a-userdebug
make systemimage -j$(nproc --all)
 ```
 
GAPPS version with erofs:

 ```
. build/envsetup.sh
ccache -M 50G -F 0
breakfast lineage_arm64_bgNE-bp4a-userdebug
make systemimage -j$(nproc --all)
 ```
 
GAPPS version with ext4:

 ```
. build/envsetup.sh
ccache -M 50G -F 0
breakfast lineage_arm64_bgN4-bp4a-userdebug
make systemimage -j$(nproc --all)
 ```
 
### Compress

After compilation,
If you want to compress the build, i recommend use [7-zip](https://aur.archlinux.org/packages/7-zip), for a fast and safe way
In rom folder,

   ```
cd out/target/product/tdgsi_arm64_ab
7z a system.img.xz "system.img"
   ```

### Troubleshoot
 
If you face any conflicts while applying patches, apply the patch manually

### Credits
These people have helped this project in some way or another, so they should be the ones who receive all the credit:
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
