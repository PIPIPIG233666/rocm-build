# rocm-build 5.3

<!--
[中文版](README_zh_CN.md)
-->

### Thanks

Thanks to [rigtorp](https://github.com/rigtorp) for providing intial build steps <https://gist.github.com/rigtorp/d9483af100fb77cee57e4c9fa3c74245> , which contains build steps for HIP on ROCm-3.6.

Thanks to [jlgreathouse](https://github.com/jlgreathouse) for providing <https://github.com/RadeonOpenCompute/Experimental_ROC> , which contains build steps for ROCm-2.0.

### Start

My environment is Gentoo.

Please download sources using repo <https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html#getting-the-rocm-source-code>,
and change the path of source in `env.sh`.

Execute `source env.sh` to setup environment variables.

Execute `bash install-dependency.sh` to install dependencies

Then execute bash scripts by order number.

Good luck.

---

### Download sources using repo.

```
doas emerge repo dev-vcs/git-lfs

mkdir -p ~/ROCm/
cd ~/ROCm/
repo init -u https://github.com/RadeonOpenCompute/ROCm.git -b roc-5.3.x
repo sync
```

### cmake version

**Note**: rocBLAS need cmake-3.18.6 from ROCm-5.3. The version of default cmake from ubuntu-20.04 is cmake-3.16.3.
We have to download <https://cmake.org/files/v3.18/cmake-3.18.6-Linux-x86_64.tar.gz> and unpack it to `/home/$whoami/Downloads`,
and execute `source env.sh` to add custom cmake to PATH environment variables.
If you want to use other location, please modify `env.sh`.

### Additional documentations:

* [check](check) - Codes for check whether ROCm can run successfully.
* [ubuntu2204](ubuntu2204) - Patches for ubuntu-22.04.

