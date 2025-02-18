# rocm-build 5.5

## profiler does NOT build due to AQLProfileLib

[中文版](README_zh_CN.md)

### Thanks

Thanks [rigtorp](https://github.com/rigtorp) providing intial build steps <https://gist.github.com/rigtorp/d9483af100fb77cee57e4c9fa3c74245> , which contains build steps for HIP on ROCm-3.6.

Thanks [jlgreathouse](https://github.com/jlgreathouse) providing <https://github.com/RadeonOpenCompute/Experimental_ROC> , which contains build steps for ROCm-2.0.

### Start

My environment is Gentoo Linux 2.13

Please download sources using repo <https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html#getting-the-rocm-source-code>,
and change the path of source in `env.sh`.

Execute `source env.sh` to setup environment variables.

Then execute bash scripts by order number.

Good luck.

---

### Download sources using repo.

```
sudo apt install -y repo

mkdir -p ~/ROCm/
cd ~/ROCm/
repo init -u https://github.com/RadeonOpenCompute/ROCm.git -b roc-5.5.x
repo sync
```

Notice: there is no repo package on ubuntu-20.04, because of slow support for python3.
<https://askubuntu.com/questions/1247103/why-is-the-repo-package-unavailable-in-ubuntu-20-04-how-can-i-install-it>

Download and install repo manually on ubuntu-20.04.

```
mkdir -p ~/bin/
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH
```

### Additional documentations:

* [gfx803](gfx803) - AMD drop gfx803 offical support on ROCm-4.0, since gfx803 is my only GPU, I need find a way to let it work longer.
* [navi10](navi10) - Experiment scripts for building navi10 GPU.
* [navi14](navi14) - Experiment scripts for building navi14 GPU.
* [check](check) - Codes for check whether ROCm can run successfully.
* [ubuntu2204](ubuntu2204) - Patches for ubuntu-22.04.

### Current version
```
[HIP]        50530201
[rocBLAS]    2.47.0.
[rocFFT]     1.0.21.
[rocPRIM]    201009
[rocRAND]    201016
[rocSPARSE]  200501
[rccl]       21505
[MIOpen]     2 19 0
[rocSOVLER]  3.21.0.
[rocThrust]  101702
[hipCUB]     201012
[hipBLAS]    0 54 0
[hipSPARSE]  200306
[hipRAND]    201016
[hipFFT]     10021
```
